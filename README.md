# Long-Running Tasks In Rails

# Objectives

1. Use Sidekiq to move a long-running task to a background worker

# Lesson

If a long-running task takes *too* long, it will frustrate users and possibly cause time-outs and lead to errors.

In our case, our sales team is happy that we gave them a way to upload leads, but they want to be able to get right back to contacting customers and not have to wait for the uploading and processing to complete.

## Workers
asd
In Rails, we talk about *workers* as processes that will allow us to execute tasks outside of the main web application thread.

The reason it takes so long to load `/customers` after uploading our file is that we are processing the file on the same thread as the request/response. File processing becomes a *blocking* action on the thread, and nothing else can happen until that's done, causing the sales person to sit and stare at a blank screen for a minute.

Fortunately, in the Rails ecosystem, we have a lot of tools we can use to move blocking tasks to a background worker and allow the main thread to continue, providing a much snappier response for the user.

## Sidekiq

One of the most popular background worker tools is [Sidekiq](https://github.com/mperham/sidekiq).

We'll use Sidekiq to move our leads processing upload to a background thread so that our sales people can go back to work on the `/customers` page right away.

Let's get it started.

First we add Sidekiq to our Gemfile and run `bundle install`:

```ruby
gem 'sidekiq'
```

Sidekiq depends on [Redis](http://redis.io/), which you'll need to install. If you're running on OS X, you can run

```bash
brew install redis
```

and follow the post-install instructions to get everything up and running.

You can also always [download Redis](http://redis.io/download) manually or exercise your Google-fu to figure out the best installation for your setup.

Sidekiq relies on a `Worker` to define and process a *job*. Let's add an `app/workers` directory and create our first worker:

```ruby
# app/workers/leads_worker.rb

class LeadsWorker
  include Sidekiq::Worker

  def perform(leads_file)

  end
end
```

That's the basic shape of any worker. You'll `include Sidekiq::Worker` and define a `perform` instance method that takes in whatever data is required to complete the job. In our case, it will be our leads file.

Now that we have our worker, we need to move the processing from the controller to the worker. All you have to do is take the long-running code out of one place, and put it inside of `perform`:

```ruby
# app/workers/leads_worker.rb

class LeadsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(leads_file)
    CSV.foreach(leads_file, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
  end
end
```

We've taken the loop that processes the file in our controller, and just put it inside of `perform`. Make sure to `require 'csv'` at the top, and update the `CSV.foreach` to work with `leads_file`.

Now, in our controller, we want to tell it to run this worker rather than process the file inline:

```ruby
# controllers/customers_controller.rb
class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def upload
    LeadsWorker.perform_async(params[:leads].path)
    redirect_to customers_path
  end
end
```

And that's it. We're now set up to run the file upload in a background worker.

To see it in action, you'll first need to start Redis: `redis-server` (on OS X you can also follow the instructions that `brew info redis` prints to start Redis automatically using launchctl). Then run your Rails server (don't forget to restart) in one tab, and open a new Terminal tab to run Sidekiq with this command:

`bundle exec sidekiq`

Your terminals may look something like this:

![][sidekiq-redis-terminal]

Then go to `/customers` and try it out. Uploading the `db/customers.csv` file should immediately redirect you to `/customers`, where you can continue your work, and periodically refresh to see new entries!

If you watch the tab running Sidekiq, you'll see something like:

`LeadsWorker JID-bca14e512da7b759ad6cf37b INFO: start`

That's how you know the job has started, and you can start refreshing the page.

## Summary

We've seen how to improve the user's experience and keep our application responsive by using Sidekiq to offload long-running tasks into a background worker.

[sidekiq-redis-terminal]: https://learn-verified.s3.amazonaws.com/sidekiq-redis-terminal.png

<p class='util--hide'>View <a href='https://learn.co/lessons/rails-sidekiq-readme'>Sidekiq</a> on Learn.co and start learning to code for free.</p>

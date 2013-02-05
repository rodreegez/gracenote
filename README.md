# Gracenote

Work In Progress Gracenote API wrapper in Ruby.

Functionality so far:

* Register with Gracenote on initialization
* Basic Track Search
* fetch artist image from gnid

## Installation

Add this line to your application's Gemfile:

    gem 'gracenote'

And then execute:

    $ bundle install


## Usage

In a Rails app, you'll want to memoise the instantiation of the client.
Try somehing like this in `config/initializers/gracenote.rb`

```ruby
  client = Gracenote.new(your_client_id)
  client.basic_track_search(artist, album, track)
```

Then you can just refer to `Gracenote.current` to do the business.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# MongoGrid

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mongo_grid`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongo_grid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongo_grid

## Usage
```ruby
MongoGrid.configure do |config|
  config.db_name = "your mongo db name" # 'app_development'
  config.db_url = "mongodb address"     # '127.0.0.1:27017'
end
```
Then there are three main methods for use:

1 grid : this method will return a mongo grid fs according previous configure

2 remove(grid_id): this method will delete a file from mongo grid file system by grid_id 

3 uploadtogrid(tempfile,{}) : this method will save the upload file into gridfs. tempfile is the raw file input data submitted by a form , like params[:logo], this method will return a hash with keys filename,grid_id,content_type,file_length , and the {} keys is within {width, height,percent} ,and only one of them , and if {} is empty? ,the images width default is 900.

see Zbox::Qm.resize  details 


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongo_grid.


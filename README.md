# MongoGrid

MongoGrid simplify rails app file upload process.
It add some method to convience uploaded file to mongodb gridfs


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
Then there are several methods for use:

- grid : this method will return a mongo grid fs according previous configure

-  remove(grid_id): this method will delete a file from mongo grid file system by grid_id 

- uploadtogrid(tempfile,{}) : this method will save the upload file into gridfs. tempfile is the raw file input data submitted by a form , like params[:logo], this method will return a hash with keys filename,grid_id,content_type,file_length , and the {} keys is within {width, height} ,and only one of them , and if {} is empty? ,the images width default is 960.
- savetogrid(fpath,fname,content_type) : this method save file to gridfs directly from file system

## Little Tools

With this gem ,there is a little tools named resize, it is used to resize the upload image , type following command to see detailed usage.
```
resize -help
```

## Extensions

### Mongoid extensions

This gem also add some dynamic methods in mongoid module.
```
- remove_XXX
- delete_medias(content)
```

remove_XXX method can be used in module callback when you want to delete a document in mongodb 

delete_medias(content) used to delete medias within content like article body

### Action Base extensions

There also three methods added in application controller :
```
- pageit
- attachit(model,attach = :attach,opts = {})
- need_role
```

- pageit used to page documentset in views
- attachit used to add uploaded file mongodb
- need_role used to add methods in controller before_action callback
```
  need_role :teacher, :admin
  # will add need_teacher, need_admin method
  # can be used like 
  # before_action :need_teacher
```
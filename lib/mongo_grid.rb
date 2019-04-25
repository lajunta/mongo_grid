require 'version'

#Dir[File.join(File.dirname(__FILE__), 'mongo_grid', '*.rb')].each do |extension|
#  require extension
#end

module ::MongoGrid
  attr_accessor :db_name, :db_url
  extend self

  def configure
    yield self
  end  

  def grid
    client = Mongo::Client.new([db_url], :database => db_name)
    client.database.fs
  end

  def remove(gid)
    id = BSON::ObjectId.from_string(gid)
    grid.delete(id)
  end

  def fsize(length)
    case length
    when 0..(1024**2)
      (length.to_f/1024.to_f).round(1).to_s+"K"
    when (1024**2)...(1024**3)
      (length.to_f/(1024**2).to_f).round(1).to_s+"M"
    when (1024**3)...(1024**4)
      (length.to_f/(1024**3).to_f).round(1).to_s+"G"
    end
  end

  def uploadtogrid(upload,opts={})
    filename=upload.original_filename
    content_type=upload.content_type
    if /jpg|jpeg|png/ =~ content_type
      if opts[:width]
        %x[resize -fixed -w #{opts[:width]} #{upload.tempfile.path}]
      else
        %x[resize -fixed #{upload.tempfile.path}]
      end

    end
    data = File.open(upload.tempfile.path)
    length=File.size(upload.tempfile.path)
    gfile = ::Mongo::Grid::File.new(data,filename: filename, metadata: {content_type: content_type,length: length})
    gid = grid.insert_one(gfile)
    file_size = fsize(length)
    hsh = {:grid_id=>gid.to_s,:filename=>filename,
           :content_type=>content_type,:file_size=>file_size}
  end

  def savetogrid(fpath,fname="poster.jpg",content_type='image/jpeg')
    data = File.open(fpath)
    length=File.size(fpath)
    gfile = ::Mongo::Grid::File.new(data,filename: fname, metadata: {content_type: content_type,length: length})
    gid = grid.insert_one(gfile)
    file_size = fsize(length)
    hsh = {:grid_id=>gid.to_s,:filename=>fname,
           :content_type=>content_type,:file_size=>file_size}

  end 
end

require 'mongoid'
require 'action_base'
require 'plug'
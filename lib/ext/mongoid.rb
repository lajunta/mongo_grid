module ::Mongoid
  module Document

    def self.included(base)
      base.include(InstanceMethods)
      #base.extend(ClassMethods)
    end

    module InstanceMethods
      # remove medias within the content
      def delete_medias(content)
        doc = Nokogiri::HTML(eval("self.#{content.to_s}"))
        #doc = Nokogiri::HTML(self.content)
        images = doc.css("img[src*='/see/']")
        if images.count>0
          images.each do |image|
            grid_id = image["src"].split("/")[2]
            MongoGrid.remove(grid_id)
          end
        end
      end

      def remove_attachs
        grid_files=eval("self.attachs")
        puts grid_files
          grid_files.each do |grid_file|
          id = BSON::ObjectId.from_string(grid_file['grid_id'])
          MongoGrid.grid.delete(id)
        end
      end

      def remove_attach
        grid_file=eval("self.attach")
        unless grid_file.blank?
          id = BSON::ObjectId.from_string(grid_file['grid_id'])
          MongoGrid.grid.delete(id)
        end
      end
    end
  end
end

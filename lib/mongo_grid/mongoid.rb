module ::Mongoid
  module Document

    %w[logo avatar attach embed].each do |name|
    module_eval(%Q(
    def remove_#{name}
      attach=self.#{name}
      unless attach.blank?
        id = BSON::ObjectId.from_string(attach['grid_id'])
        MongoGrid.grid.delete(id)
      end
    end
    ))
    end
  end
end

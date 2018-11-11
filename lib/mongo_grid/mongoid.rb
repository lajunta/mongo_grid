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

=begin
    def self.included(base)
      base.class_eval(%Q(
          before_destroy :remove_logo
          before_destroy :remove_avatar
          before_destroy :remove_attach
      ))
    end
=end

  end
end

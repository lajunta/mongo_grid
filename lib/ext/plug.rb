module ::Plug
  module Mixin

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def array_attr(attr)
        attr = attr.to_s
        self.class_eval(%Q{
          def #{attr}_list
            return "" if self.#{attr}.blank?  
            self.#{attr}.join(",")
          end
          def #{attr}_list=(value)
            self.#{attr} = value.split(",") if !value.blank?
          end
        })
      end
    end
    
  end
end
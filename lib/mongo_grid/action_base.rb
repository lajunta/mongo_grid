require "action_controller"

ActionController::Base.class_eval do
  def self.need_role(*roles)
    roles.each do |role|
      eval(%Q(
      def need_#{role.to_s} 
      unless is_#{role.to_s}?
        flash[:alert] = "身份不对"
        redirect_to login_path and return
      end
      end
      ))
    end
  end

  def attachit(model,attach = :attach,opts = {})
    unless params[model.to_sym][attach].blank?
      if params[:action] == 'update'
        old_attach = eval("@#{model}.#{attach.to_s}")
        unless old_attach.blank?
          id = BSON::ObjectId.from_string(old_attach['grid_id'])
          MongoGrid.grid.delete(id)
        end
      end
      attach=params[model.to_sym][attach]
      MongoGrid.uploadtogrid(attach,opts)
    end
  end

  def pageit
    params[:page] ||= 1   
    per_page = 10
    @num=per_page*(params[:page].to_i-1)
  end

end

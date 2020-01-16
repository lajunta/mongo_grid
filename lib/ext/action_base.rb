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
    attachs=params[attach.to_sym]
    attachs_ary=[]
    unless attachs.blank?
      attachs.each {|att| attachs_ary << ::MongoGrid.uploadtogrid(att)}
      if params[:action] == "update"
        old_attachs = evel("@#{model}.#{attach.to_s}")
        attachs_ary=attachs_ary+old_attachs unless old_attachs.blank?
      end
    end
    return attachs_ary
  end

  def pageit
    params[:page] ||= 1   
    per_page = 10
    @num=per_page*(params[:page].to_i-1)
  end

end

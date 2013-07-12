#coding: utf-8
module ApplicationHelper
	def controller?(*controller)
    	controller.include?(params[:controller])
  end

end

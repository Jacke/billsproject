class ShiftsController < ApplicationController
before_filter :set_site #, only: %w(index)


def index
  redirect_to sites_path unless @site
  @status = @site.shiftstatus
  @shifts = Shift.where(site_id: @site.id).last
end

def new
	if @site.shiftstatus
		@shift = Shift.where(site_id: @shift.id).last 
  else
  	accept_shift
  	Shift.new(employee_id: 1)
  	redirect_to shifts_path(site: @site.id)
  end
end

def create
 @shift = Shift.new(params[:shift]) 
 cancel_shift if @shift.save
 redirect_to shifts_path(site: @site.id)
end


private
def accept_shift; change_bool; end
def cancel_shift; change_bool; end

def set_site
   @site = Site.find(params[:site]) if params[:site]
   #@site = Site.find(params[:shift][:site_id]) if params[:shift][:site_id] && @site
end

def change_bool
  if @site.shiftstatus
  	@site.update_attribute :shiftstatus, false
  else
  	@site.update_attribute :shiftstatus, true
  end
end

end

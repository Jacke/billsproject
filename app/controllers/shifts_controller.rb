# TODO: Clean up actions
# TODO: Check for @caattr safety
class ShiftsController < ApplicationController
before_filter :set_site #, only: %w(index)

before_filter :set_current_site

def index
  redirect_to sites_path unless @site
  @status = @site.shiftstatus
  @shifts = Shift.where(site_id: @site.id).last
end

def new
	if @site.shiftstatus # Cancel shift
		@shift = Shift.where(site_id: @site.id).last 
		@shift.shift_row_assigns.build
  else 								 # Accept shift
  	@shift = Shift.new(employee_id: 1, site_id: @site.id)
  	render "accept"
  end
end

def create
 @shift = Shift.new(params[:shift]) 
 change_bool if @shift.save
 redirect_to shifts_path(site: @site.id)
end

def update
 @shift = Shift.find(params[:id])
 if @shift.update(params[:shift]) 
 	  change_bool
 	  @shift.update_attributes(till: @shift.till_calc)
 end
 redirect_to shifts_path(site: @site.id)
end

def set_current_site
  #  set @current_account from session data here
  Shift.current_site = @site.shiftstatus
end

def revert_shift # REVERT FEATURE
	@shift = Shift.find(params[:id])
  redirect_to edit_shift_path(@shift)
end

private

def set_site
	 params[:site].present? ? site = params[:site] : site = params[:shift]["site_id"] # New shift or Shift in form
   @site = Site.find(site)
end

def change_bool
  if @site.shiftstatus
  	@site.update_attribute :shiftstatus, false
  else
  	@site.update_attribute :shiftstatus, true
  end
end

end

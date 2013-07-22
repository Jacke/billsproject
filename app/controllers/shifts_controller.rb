class ShiftsController < ApplicationController
before_filter :set_site #, only: %w(index)


def index
  redirect_to sites_path unless @site
  @status = @site.shiftstatus
  @shifts = Shift.where(site_id: @site.id).last
end

def new
	  @rows = ShiftRow.where(site_id: nil)
	if @site.shiftstatus # Cancel shift
		@shift = Shift.where(site_id: @site.id).last 
		@shift.shift_row_assigns.build
  else 								 # Accept shift
  	@shift = Shift.new(employee_id: 1, site_id: @site.id)
  	accept_shift if @shift.save
  	redirect_to shifts_path(site: @site.id) 
  end
end

def create
 @shift = Shift.new(params[:shift]) 
 cancel_shift if @shift.save
 redirect_to shifts_path(site: @site.id)
end

def update
 @shift = Shift.find(params[:id])
 accept_shift if @shift.update(params[:shift]) 
 redirect_to shifts_path(site: @site.id)
end

def revert_shift # REVERT FEATURE
	@shift = Shift.find(params[:id])
  redirect_to edit_shift_path(@shift)
end

private
def accept_shift; change_bool; end
def cancel_shift; change_bool; end

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

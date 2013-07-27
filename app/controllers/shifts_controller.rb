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
  else 								 # Accept shift Admin action
  	@shift = Shift.new(employee_id: 1, site_id: @site.id)
  	render "accept_from_user"
  end
end

def create
 @shift = Shift.new(params[:shift]) 
 change_bool if @shift.save && params[:shift][:employee_id].present?
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

def balance
    @hoar = balance_obj.hoar_row if balance_obj.hoar_row.present?
    @hoar = balance_obj.build_hoar_row unless balance_obj.hoar_row.present?
    @shift = balance_obj
    @shift.shift_row_assigns.build
    render "balance"
end

 #Parameters: "shift"=>{"hoar_row"=>{"balance"=>"9000", "till"=>"0"}, 
 #"shift_row_assigns_attributes"=>{"0"=>{"shift_row_id"=>"8", "def"=>"", "_destroy"=>"false"}}}, 
 #"commit"=>"Сохранить", "id"=>"19"}

def balance_update
  @shift = Shift.find(params[:shift][:id])
  if @shift.hoar_row.present?
    @hoar = @shift.hoar_row.update(params[:shift][:hoar_row])
  else
    @hoar = @shift.build_hoar_row(params[:shift][:hoar_row])
    @hoar.save 
  end

  @shift.update("shift_row_assigns_attributes" => params[:shift][:shift_row_assigns_attributes])
    
  redirect_to shifts_path(site: @site.id), notice: 'good'

end

def revert_shift # REVERT FEATURE
	@shift = Shift.find(params[:id])
  redirect_to edit_shift_path(@shift)
end

private

def balance_obj
  request = Shift.where(site_id: @site.id).last
end

def set_current_site
  #  set @current_account from session data here
  Shift.current_site = @site.shiftstatus
end

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

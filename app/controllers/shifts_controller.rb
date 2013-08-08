# TODO: Clean up actions
# TODO: Check for @caattr safety
class ShiftsController < ApplicationController
before_filter :set_site, except: %w(destroy)

before_filter :set_current_site, except: %w(destroy)
before_filter :put_empty_shift, only: %w(balance)

def index
  redirect_to sites_path unless @site
  @status = @site.shiftstatus
  @shifts = Shift.where(site_id: @site.id).last
end

def new
  target = Shift.where(site_id: @site.id).last
	if @site.shiftstatus # Cancel shift
		@shift = target
		@shift.shift_row_assigns.build
  else 								 # Accept shift Admin action
    @shift = target unless target.employee_id.present?
  	@shift ||= Shift.new(employee_id: 1, site_id: @site.id)
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
    if @shift.site.shiftstatus # calculation need or not?
      @shift.old_values_collect
      @shift.row_collect
      @shift.till_save
    end
 	  change_bool
 end
 redirect_to shifts_path(site: @site.id)
end
def destroy; Shift.find(params[:id]).destroy; redirect_to sites_path; end;
def balance
    @hoar = balance_obj.hoar_row if balance_obj.hoar_row.present?
    @hoar = balance_obj.build_hoar_row unless balance_obj.hoar_row.present?
    @shift = balance_obj
    @shift.shift_row_assigns.build
    render "balance"
end

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

def deposit
  @employee = current_employee
  @merchant = @employee.merchant
  render 'employees/deposit'
end

def deposit_update
  @employee = Employee.find(params[:employee][:id])
  @employee.merchant.update(params[:employee][:merchant])
end

def revert_shift # REVERT FEATURE
	@shift = Shift.find(params[:id])
  redirect_to edit_shift_path(@shift)
end

private

def put_empty_shift
  if @site.shiftstatus == false
    z = @site.shifts.new 
    z.save
  end
end

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
    @shift.update_attribute :cancel_at, Time.now
  else
  	@site.update_attribute :shiftstatus, true
    @shift.update_attribute :accept_at, Time.now
  end
end

end

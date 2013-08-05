class HistoriesController < ApplicationController

def index
  @shifts = Shift.all
  @hoar = HoarRow.all
end

def edit
 @shift = Shift.find(params[:id]) 
 #  change_bool if @shift.save && params[:shift][:employee_id].present?
 #  redirect_to shifts_path(site: @site.id)
 @hoar = @shift.hoar_row
 @shift_row_assigns = @shift.shift_row_assigns
 @rows = ShiftRow.where('site_id IS NULL').collect {|r| [ "#{r.title} : #{r.rowtype}", r.id ] }
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


end

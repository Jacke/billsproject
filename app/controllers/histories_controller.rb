class HistoriesController < ApplicationController

def index
  @shifts = Shift.all
  @hoar = HoarRow.all
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


end

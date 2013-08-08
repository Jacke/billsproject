class HistoriesController < ApplicationController

def index
    @sites = Site.all
  if params[:sort].present?
    @shifts = Shift.last_week if params[:sort] == 'by_week'
    @shifts = Shift.all.last_month if params[:sort] == 'by_month'
    @hoar = HoarRow.all
  else
    @shifts = Shift.all
    @hoar = HoarRow.all
  end
  if params[:sort] == 'by_site'
    @shifts ||= Shift.all
    @shifts = @shifts.by_site(params[:site])
  end
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
 redirect_to histories_path
end

def update_hoar
 @hoar = HoarRow.find(params[:id])
 if @hoar.update(params[:hoar_row])
    @shift = @hoar.shift
    @shift.old_values_collect
    @shift.row_collect
    @shift.till_save
 end
 redirect_to histories_path
end

private

def recalculate
 # your code is here
end

end


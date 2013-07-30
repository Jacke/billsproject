class EmployeesController < ApplicationController
	#  before_filter :authenticate_admin!
	def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
    render "_form"
  end

  def edit
    @employee = Employee.find(params[:id])
    render "_form"
  end
  
  def show
    @employee = Employee.find(params[:id])
    @shifts = @employee.shifts
  end

  def create
    @employee = Employee.new(params[:employee])
    # @employee.payrate = (@employee.payrate/100)
    if @employee.save
      redirect_to employees_url, notice: "Сотрудник создан."
    else
      redirect_to employees_url, warning: "Something wrong" 
    end
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update_attributes(params[:employee])
    if @employee.save
      redirect_to employees_url, notice: "Сотрудник обновлен."
    else
      redirect_to employees_url, warning: "Something wrong" 
    end
  end
  
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_url, notice: "Сотрудник удален."
  end
  
end

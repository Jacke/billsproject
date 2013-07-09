class EmployeeController < ApplicationController
	before_filter :authenticate_admin!
	def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employees.find(params[:id])
  end

  def create
    @employee = Employees.new(params[:employee])
    # @employee.payrate = (@employee.payrate/100)
    @employee.save
    redirect_to employees_url, notice: "Employee successfully created."
  end
  def show
      @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update_attributes(params[:employee])
    @employee.save
    redirect_to employees_url, notice: "Employee successfully updated."
  end
  
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_url, notice: "Employee deleted."
  end
end

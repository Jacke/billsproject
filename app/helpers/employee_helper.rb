module EmployeeHelper
  
  def admin?(admin_var)
    admin_var ? "Admin" : "User"
  end

end

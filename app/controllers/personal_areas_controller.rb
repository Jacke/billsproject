class PersonalAreasController < ApplicationController
before_filter :authenticate_employee!
def index
    @employee = current_employee
    @shifts = @employee.shifts
end

def cashout

end

end

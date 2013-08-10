# TODO: Move methods to concerns
# TODO: Remade collection method (One line request, instance var assignment)
# TODO: Callback cleaning up
class Shift < ActiveRecord::Base
	cattr_accessor :current_site
	include ShiftCalculation
  # callback for cancel shift

  # callback for accept shift
  before_save :retrive_last_shift, :unless => :current_site
  after_save :retrive_old_vls, :unless => :current_site

  attr_accessible :shiftstatus, 
								  :site_id, 
								  :employee_id, 
								  :balance, 
								  :till, 
								  :comment,
								  :shift_rows_attributes, 
								  :shift_row_assigns_attributes,
								  :percent, 
								  :shift_row_id,
                  :hoar_row,
                  :cancel_at,
                  :accept_at


# row instance scope
  def self.row_scope(name, body)
    send(:define_method, name, &body)
  end

# Initialize instance scope for every row type, retrive values

    row_scope :balance_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 1 }, shift_id: o.id).pluck(:def)  }
    row_scope :cashoutnow_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 2 }, shift_id: o.id).pluck(:def)  }
    row_scope :encashmentin_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 3 }, shift_id: o.id).pluck(:def)  }
    row_scope :encashmentout_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 4 }, shift_id: o.id).pluck(:def)  }
    row_scope :expenses_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 5 }, shift_id: o.id).pluck(:def)  }
    row_scope :oldbalance_vls, ->(o = self) {ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 6 }, shift_id: o.id).pluck(:def)  }
    
    scope :last_week, -> { where("shifts.created_at >= :date", :date => 1.week.ago) } 
    scope :last_month, -> { where("shifts.created_at >= :date", :date => 1.month.ago) }
    scope :by_site, ->(site_id) { where(site_id: site_id) }

# Associations
	  has_many :shift_row_assigns 
    has_one :hoar_row
	  has_many :shift_rows, through: :shift_row_assigns  
	  belongs_to :employee
	  belongs_to :site
	  accepts_nested_attributes_for :shift_rows, :hoar_row
    accepts_nested_attributes_for :shift_row_assigns, reject_if: proc { |attributes| attributes['def'].blank? }

# instance methods
  def current_site
    Shift.current_site
  end

  def hoar_obj
    self.hoar_row
  end

  def retrive_last_shift
    @last_shift = Shift.where(site_id: self.site_id).last
  end
  
  def retrive_old_vls # from previous shift
    if @last_shift.present?
      balance = @last_shift.balance.to_i #+ @last_shift.balance_vls.map(&:to_i).inject(:+).to_i 
      till = @last_shift.till
      logger.info "TEST IMPORTANT #{self}"
      unless self.hoar_row.present?
       if self.build_hoar_row(till: till, balance: balance).save 
          k = adi_balance_diffy(@last_shift)
          k.each do |k,v|
            self.shift_row_assigns.new(shift_row_id: k, def: v).save
          end if k.present?
       end
      end
    end
  end 

  def adi_balance_diffy(object)
    old = ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 1 }, shift_id: object.id).pluck(:def) 
    old_ids = ShiftRow.joins(:shift_row_assigns).where(shift_row_assigns: { shift_id: object.id }, row_type: 6).pluck(:id)
    fresh = ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: 6 }, shift_id: object.id).pluck(:def) 
    l = []
    logger.info "old #{old}"
    logger.info "fresh #{fresh}"
    if old.present? && fresh.present?
      (0..fresh.count-1).each {|n| l << old[n] } # old[n] } # TODO: change fresh to old so it be syntacly -]f, g| 
      Hash[old_ids.zip(l)] # => {1=>133, 2=>33}
    end
  end

  def old_values_collect 
       @init_balance = hoar_obj.balance.to_i #+ self.oldbalance_vls.map(&:to_i).inject(:+).to_i
       @init_till = hoar_obj.till # Define by admin at begining
  end
  
  def many_balance_diff
    old = self.oldbalance_vls # [4242, 1122]
    fresh = self.balance_vls # [6242, 4122]
    if old.count == fresh.count 
      l = []
      (0..fresh.count-1).each {|n| l << (old[n] - fresh[n]) }
      l.inject(:+).to_i
    else 
      0
    end 
  end

  def row_collect # that set after cancel shift
   balance = self.balance.to_i #+ self.balance_vls.map(&:to_i).inject(:+).to_i 
   balance_diff = @init_balance.to_i - balance # Diff for init balance and new(for all rows)
   @balance_diff = balance_diff + many_balance_diff
   @cashouts = self.cashoutnow_vls.map(&:to_i).inject(:+).to_i
   @encashmentIn = self.encashmentin_vls.map(&:to_i).inject(:+).to_i
   @encashmentOut = self.encashmentout_vls.map(&:to_i).inject(:+).to_i
   @expenses = self.expenses_vls.map(&:to_i).inject(:+).to_i
   @percent = self.percent.to_i
  end
  
  def till_calc
   self.employee.put_cashouts(@cashout)
   till = @init_till.to_i + @balance_diff.to_i + @encashmentOut.to_i - @cashouts - @expenses.to_i - @encashmentIn.to_i - @percent.to_i
   till
  end

  def till_save
    result = self.till_calc
    logger.info "BUUUUUUUUUUUUUUUUZ #{result}"
    self.update_attribute :till, result
  end 
# TODO: Default values in DB for refactoring that shift upper


end

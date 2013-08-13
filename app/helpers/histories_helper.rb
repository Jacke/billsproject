module HistoriesHelper

  def shifts_sum
    @shifts_sum
  end
  def set_sum(type, vls)
    @shifts_sum = {} if @shifts_sum.nil?
    sums = shifts_sum
    if sums[type].present? && vls.present?
       sums[type] += vls
    else
       sums[type] = vls if vls.present?
    end
  end
end

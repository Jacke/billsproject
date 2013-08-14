module HistoriesHelper

  def shifts_sum
    @shifts_sum
  end
  def native_diff
    @native_diff
  end
  def diffsum
    @diffs_sum
  end

  def set_ndi(vls)
    @native_diff = 0 if @native_diff.nil?
    @native_diff += vls
  end
  def set_diffsum(type, vls)
    @diffs_sum = {} if @diffs_sum.nil?
    diffsum = @diffs_sum
    if diffsum[type].present? && vls.present?
      diffsum[type] += vls
    else
      diffsum[type] = vls if vls.present?
    end
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

module HistoriesHelper
  mattr_reader :shifts_sum

  def set_sum(type, vls)
    @@shifts_sum = {} unless @@shifts_sum.class == Hash 
    if @@shifts_sum[type].present?
      @@shifts_sum[type] =+ vls
    else
      @@shifts_sum[type] = vls
    end
  end
end

class Checkpoint < ActiveRecord::Base

  before_validation :get_next_order, :on => :create

  validates :message, presence: true, uniqueness: true
  validates :response, presence: true
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :order, numericality: { only_integer: true, greater_than: 0 }

  def success_message
    if self.success.blank?
      self.response
    else
      "#{self.success} #{self.response}"
    end
  end

  private

  def get_next_order
    self.order = Checkpoint.count + 1
  end

end


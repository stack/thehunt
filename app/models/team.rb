class Team < ActiveRecord::Base

  has_many :logs
  has_many :people

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :people

  def started?
    self.position != 0
  end

  def start!
    unless started?
      self.update_attribute :position, 1
    end
  end

  def reset!
    self.update_attribute :position, 0
  end

end


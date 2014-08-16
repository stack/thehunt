class Team < ActiveRecord::Base

  has_many :people

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end


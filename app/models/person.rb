class Person < ActiveRecord::Base

  belongs_to :team
  has_many :logs

  validates :number, presence: true, uniqueness: true, format: /\A\+[0-9]{11}\z/

  def description
    if self.name.blank?
      self.number
    else
      self.name
    end
  end

end

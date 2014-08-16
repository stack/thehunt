class Log < ActiveRecord::Base

  belongs_to :checkpoint
  belongs_to :team
  belongs_to :person

end


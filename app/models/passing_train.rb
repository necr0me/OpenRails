class PassingTrain < ApplicationRecord
  belongs_to :station
  belongs_to :train

  def destination
    self.train.destination
  end

end

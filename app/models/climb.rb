class Climb < ActiveRecord::Base
  belongs_to :scoresheet
  belongs_to :route
  after_initialize :init

  validates :route_id, presence: true
  validates :scoresheet_id, presence: true
  validates :attempts, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def attempt
    self.attempts += 1
  end


  def init
    self.attempts = 0
    self.sent = false
    self.witness = ""
  end


end

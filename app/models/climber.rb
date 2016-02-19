class Climber < ActiveRecord::Base
  belongs_to :college
  has_many :climbs, through: :scoresheets
  has_many :comps, through: :scoresheets
  has_many :scoresheets

  validates :ccs_id, presence: true
  validates :name, presence: true

  enum gender: [:male, :female]
end

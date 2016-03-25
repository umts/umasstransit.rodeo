class CircleCheckScore < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :total_defects, :defects_found, presence: true
  validates :participant, uniqueness: true

  TOTAL_DEFECTS_DEFAULT = 5

  def score
    (50 / total_defects) * defects_found
  end
end

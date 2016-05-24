class QuizScore < ActiveRecord::Base
  has_paper_trail

  belongs_to :participant

  validates :participant, :points_achieved, :total_points, presence: true
  validates :participant, uniqueness: true

  TOTAL_POINTS_DEFAULT = 100

  def score
    (50 / total_points * points_achieved).round 1
  end
end

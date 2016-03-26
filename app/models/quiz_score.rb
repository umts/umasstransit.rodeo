class QuizScore < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :points_achieved, :total_points, presence: true
  validates :participant, uniqueness: true

  TOTAL_POINTS_DEFAULT = 100

  def score
    (50 / total_points) * points_achieved
  end
end

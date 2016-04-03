class OnboardJudging < ActiveRecord::Base
  has_paper_trail

  belongs_to :participant
  validates :participant, uniqueness: true
  validates :score, :minutes_elapsed, :seconds_elapsed, presence: true

  before_validation :set_score

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    if user_id
      User.find_by id: user_id
    end
  end

  private

  def set_score
    score = 50
    score -= missed_turn_signals
    score -= 3 * missed_horn_sounds
    score -= 3 * missed_flashers
    score -= 3 * times_moved_with_door_open
    score -= 10 * unannounced_stops
    score -= sudden_stops
    score -= sudden_starts
    score -= abrupt_turns
    if minutes_elapsed >= 7
      score -= 60 * (minutes_elapsed - 7) + seconds_elapsed
    end
    assign_attributes score: score
  end
end

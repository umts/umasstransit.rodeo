class DistanceTarget < ActiveRecord::Base
  belongs_to :maneuver

  validates :x, :y, :direction, :intervals,
            :multiplier, :maneuver, :name, :minimum,
            presence: true

  def index
    maneuver.distance_targets.order(:id).index self
  end

  def interval_type
    if intervals.zero? then 'inches'
    else 'marks'
    end
  end
end

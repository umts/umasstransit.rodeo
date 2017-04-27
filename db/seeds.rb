require 'factory_girl_rails'
require 'ffaker'

exit if Rails.env.test?

man_names = ['Serpentine', 'Offset Street', 'Rear Dual Clearance',
 'Right Turn', 'Right Reverse', 'First Passenger Stop',
 'Left Turn', 'Left Reverse', 'Second Passenger Stop']

maneuvers = {}

man_names.each do |man_name|
  maneuvers[man_name] = FactoryGirl.create :maneuver, name: man_name
end
maneuvers['Diminishing Clearance'] = FactoryGirl.create :maneuver,
                                                         name: 'Diminishing Clearance',
                                                         speed_target: 20
maneuvers['Judgement Stop'] = FactoryGirl.create :maneuver,
                                                  name: 'Judgement Stop',
                                                  counts_additional_stops: true

# Serpentine
([10] * 14 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Serpentine']
end

# Offset street
([10] * 20).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Offset Street']
end

# Rear dual clearance
([20, 16, 8, 4, 2] * 2).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'ball',
    maneuver: maneuvers['Rear Dual Clearance']
end

# Right turn
([10] * 11 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Right Turn']
end

FactoryGirl.create :distance_target, intervals: 5, multiplier: 5, minimum: 0,
  maneuver: maneuvers['Right Turn'], name: 'pivot cone'

# Right reverse
([5] * 50 + [10, 25]).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Right Reverse']
end

FactoryGirl.create :distance_target, intervals: 5, multiplier: 5, minimum: 0,
  maneuver: maneuvers['Right Reverse'], name: 'rear cone'

# First passenger stop
([25] * 6).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['First Passenger Stop']
end

([25] * 5).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'curb',
    maneuver: maneuvers['First Passenger Stop']
end

FactoryGirl.create :distance_target, intervals: 0, multiplier: 1, minimum: 6,
  maneuver: maneuvers['First Passenger Stop'], name: 'front tire to curb'

FactoryGirl.create :distance_target, intervals: 0, multiplier: 1, minimum: 15,
  maneuver: maneuvers['First Passenger Stop'], name: 'rear tire to curb'

# Left turn
([10] * 8 + [25] * 2).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Left Turn']
end

# Left reverse
([5] * 50 + [10, 25]).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Left Reverse']
end

FactoryGirl.create :distance_target, intervals: 5, multiplier: 5, minimum: 0,
  maneuver: maneuvers['Left Reverse'], name: 'rear cone'

# Second passenger stop
([25] * 6).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Second Passenger Stop']
end

([25] * 5).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'curb',
    maneuver: maneuvers['Second Passenger Stop']
end

FactoryGirl.create :distance_target, intervals: 0, multiplier: 1, minimum: 6,
  maneuver: maneuvers['Second Passenger Stop'], name: 'front tire to curb'

FactoryGirl.create :distance_target, intervals: 0, multiplier: 1, minimum: 15,
  maneuver: maneuvers['Second Passenger Stop'], name: 'rear tire to curb'

# Diminishing clearance
([20, 16, 8, 4, 2] * 2).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'barrel',
    maneuver: maneuvers['Diminishing Clearance']
end

# Judgement stop
FactoryGirl.create :obstacle, point_value: 50, obstacle_type: '18" marker',
  maneuver: maneuvers['Judgement Stop']

FactoryGirl.create :distance_target, intervals: 0, multiplier: 1, minimum: 6,
  maneuver: maneuvers['Judgement Stop'], name: 'marker cone to front of bus'

unless Rails.env.production? || ENV['SKIP_PARTICIPANTS']
  bus = FactoryGirl.create :bus
  35.times do |i|
    p = FactoryGirl.create :participant, name: FFaker::Name.name, bus: bus
    maneuvers.each do |_name, m|
      mp = ManeuverParticipant.new participant: p, maneuver: m, reversed_direction: 0, completed_as_designed: true
      unless m.name.include?('Passenger') || rand(4) == 3
        m.obstacles.order('rand()').take(2).each do |obst|
          mp.obstacles_hit[obst.point_value] ||= 0
          mp.obstacles_hit[obst.point_value] += 1
        end
      end
      dt = m.distance_targets.order('rand()').first
      if dt
        mp.distances_achieved[[dt.minimum, dt.multiplier]] = rand(3)
      end
      mp.save!
    end
    CircleCheckScore.create! participant: p, total_defects: 5, defects_found: rand(5)
    QuizScore.create! participant: p, total_points: 100, points_achieved: rand(100)
    OnboardJudging.create! participant: p, minutes_elapsed: (6 + rand(3)), seconds_elapsed: rand(59),
      missed_turn_signals: 0, missed_flashers: rand(1), missed_horn_sounds: rand(1), times_moved_with_door_open: 0,
      unannounced_stops: 0, sudden_stops: 0, sudden_starts: 0, abrupt_turns: 0
  end
  15.times { FactoryGirl.create :participant, name: FFaker::Name.name }

  FactoryGirl.create :user, name: 'Karin Eichelman',
                            email: 'karin@example.com',
                            password: 'password',
                            admin: true
  FactoryGirl.create :user, name: 'Jake Brians',
                            email: 'jbox@example.com',
                            password: 'password',
                            master_of_ceremonies: true
end

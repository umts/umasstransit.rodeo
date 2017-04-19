require 'factory_girl_rails'
require 'ffaker'

exit if Rails.env.test?

man_names = ['Backwards Serpentine', 'Judgement Stop', 'Left Turn',
  'Diminishing Clearance', 'Right Turn', 'Offset Alley']

maneuvers = {}

man_names.each do |man_name|
  maneuvers[man_name] = FactoryGirl.create :maneuver, name: man_name
end

# 1 Backwards Serpentine
5.times do
  FactoryGirl.create :obstacle, point_value: 10, obstacle_type: 'cone',
    maneuver: maneuvers['Backwards Serpentine']
end
maneuvers['Backwards Serpentine'].update_attributes(counts_reverses: true,
                                                    reverse_points: 5)

# 2 Judgement stop
FactoryGirl.create :obstacle, point_value: 50, obstacle_type: '18" marker',
  maneuver: maneuvers['Judgement Stop']

FactoryGirl.create :distance_target, intervals: 0, multiplier: 50, minimum: 12,
  maneuver: maneuvers['Judgement Stop'], name: 'marker cone to front of van'

# 3 Left Turn
([10] * 5 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Left Turn']
end
maneuvers['Left Turn'].update_attributes(counts_reverses: true,
                                         reverse_points: 15)

# 4 Diminishing Clearance
([20, 16, 8, 4, 2] * 2).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'ball',
    maneuver: maneuvers['Diminishing Clearance']
end
maneuvers['Diminishing Clearance'].update_attributes(speed_target: 10)

# 5 Right turn
([10] * 5 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Right Turn']
end

# 6 Offset Alley
([10] * 16).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Offset Alley']
end
maneuvers['Offset Alley'].update_attributes(counts_reverses: true,
                                            reverse_points: 10)

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

  FactoryGirl.create :user, name: 'David Faulkenberry',
                            email: 'dave@example.com',
                            password: 'password',
                            admin: true
  FactoryGirl.create :user, name: 'Jake Brians',
                            email: 'jbox@example.com',
                            password: 'password',
                            master_of_ceremonies: true
end

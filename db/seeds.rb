# frozen_string_literal: true

require 'factory_bot_rails'

exit if Rails.env.test?

man_names = ['Serpentine', 'Offset Street', 'Rear Dual Clearance',
             'Right Turn', 'Right Reverse', 'First Passenger Stop',
             'Left Turn', 'Left Reverse', 'Second Passenger Stop']

maneuvers = {}

man_names.each do |man_name|
  maneuvers[man_name] = FactoryBot.create :maneuver, name: man_name
end

maneuvers['Diminishing Clearance'] =
  FactoryBot.create :maneuver,
                    name: 'Diminishing Clearance',
                    speed_target: 20
maneuvers['Judgement Stop'] =
  FactoryBot.create :maneuver,
                    name: 'Judgement Stop',
                    counts_additional_stops: true

(([10] * 14) << 25).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Serpentine']
end

([10] * 20).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Offset Street']
end

([20, 16, 8, 4, 2] * 2).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'ball',
                    maneuver: maneuvers['Rear Dual Clearance']
end

(([10] * 11) << 25).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Right Turn']
end

FactoryBot.create :distance_target,
                  intervals: 5,
                  multiplier: 5,
                  minimum: 0,
                  maneuver: maneuvers['Right Turn'],
                  name: 'pivot cone'

(([5] * 50) + [10, 25]).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Right Reverse']
end

FactoryBot.create :distance_target,
                  intervals: 5,
                  multiplier: 5,
                  minimum: 0,
                  maneuver: maneuvers['Right Reverse'],
                  name: 'rear cone'

([25] * 6).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['First Passenger Stop']
end

([25] * 5).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'curb',
                    maneuver: maneuvers['First Passenger Stop']
end

FactoryBot.create :distance_target,
                  intervals: 0,
                  multiplier: 1,
                  minimum: 6,
                  maneuver: maneuvers['First Passenger Stop'],
                  name: 'front tire to curb'

FactoryBot.create :distance_target,
                  intervals: 0,
                  multiplier: 1,
                  minimum: 15,
                  maneuver: maneuvers['First Passenger Stop'],
                  name: 'rear tire to curb'

(([10] * 8) + ([25] * 2)).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Left Turn']
end

(([5] * 50) + [10, 25]).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Left Reverse']
end

FactoryBot.create :distance_target,
                  intervals: 5,
                  multiplier: 5,
                  minimum: 0,
                  maneuver: maneuvers['Left Reverse'],
                  name: 'rear cone'

([25] * 6).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'cone',
                    maneuver: maneuvers['Second Passenger Stop']
end

([25] * 5).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'curb',
                    maneuver: maneuvers['Second Passenger Stop']
end

FactoryBot.create :distance_target,
                  intervals: 0,
                  multiplier: 1,
                  minimum: 6,
                  maneuver: maneuvers['Second Passenger Stop'],
                  name: 'front tire to curb'

FactoryBot.create :distance_target,
                  intervals: 0,
                  multiplier: 1,
                  minimum: 15,
                  maneuver: maneuvers['Second Passenger Stop'],
                  name: 'rear tire to curb'

([20, 16, 8, 4, 2] * 2).each do |obst_point|
  FactoryBot.create :obstacle,
                    point_value: obst_point,
                    obstacle_type: 'barrel',
                    maneuver: maneuvers['Diminishing Clearance']
end

FactoryBot.create :obstacle,
                  point_value: 50,
                  obstacle_type: '18" marker',
                  maneuver: maneuvers['Judgement Stop']

FactoryBot.create :distance_target,
                  intervals: 0,
                  multiplier: 1,
                  minimum: 6,
                  maneuver: maneuvers['Judgement Stop'],
                  name: 'marker cone to front of bus'

exit if Rails.env.production? || ENV['SKIP_PARTICIPANTS']

require 'faker'

bus = FactoryBot.create :bus
35.times do
  p = FactoryBot.create(:participant, name: Faker::Name.name, bus:)

  maneuvers.each_value do |m|
    mp = ManeuverParticipant.new participant: p,
                                 maneuver: m,
                                 reversed_direction: 0,
                                 completed_as_designed: true
    unless m.name.include?('Passenger') || rand(4).zero?
      m.obstacles.order('rand()').take(2).each do |obst|
        mp.obstacles_hit[obst.id] ||= [obst.point_value, 0]
        mp.obstacles_hit[obst.id][1] += 1
      end
    end
    dt = m.distance_targets.order('rand()').first
    mp.distances_achieved[[dt.minimum, dt.multiplier]] = rand(3) if dt
    mp.save!
  end

  CircleCheckScore.create! participant: p,
                           total_defects: 5,
                           defects_found: rand(0..5)
  QuizScore.create! participant: p,
                    total_points: 100,
                    points_achieved: rand(0..100)
  OnboardJudging.create! participant: p,
                         minutes_elapsed: rand(6..8),
                         seconds_elapsed: rand(60),
                         missed_turn_signals: 0,
                         missed_flashers: rand(2),
                         missed_horn_sounds: rand(2),
                         times_moved_with_door_open: 0,
                         unannounced_stops: 0,
                         sudden_stops: 0,
                         sudden_starts: 0,
                         abrupt_turns: 0
end

15.times { FactoryBot.create :participant, name: Faker::Name.name }

FactoryBot.create :user, name: 'Karin Eichelman',
                         email: 'karin@example.com',
                         password: 'password',
                         admin: true
FactoryBot.create :user, name: 'Jake Brians',
                         email: 'jbox@example.com',
                         password: 'password',
                         master_of_ceremonies: true

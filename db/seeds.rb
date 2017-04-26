require 'factory_girl_rails'
require 'ffaker'

exit if Rails.env.test?

man_names = ['Backwards Serpentine', 'Rear Judgement Stop', 'Left Turn',
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
3.times do 
  FactoryGirl.create :obstacle, point_value: 50, obstacle_type: 'cone',
    maneuver: maneuvers['Rear Judgement Stop']
end

FactoryGirl.create :distance_target, intervals: 0, multiplier: 50, minimum: 18,
  maneuver: maneuvers['Rear Judgement Stop'], name: 'any of the cones to back of van'

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
maneuvers['Diminishing Clearance'].update_attributes(speed_target: 10,
                                                     counts_reverses: false)

# 5 Right turn
([10] * 5 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Right Turn']
end
maneuvers['Right Turn'].update_attributes(counts_reverses: true,
                                          reverse_points: 15)

# 6 Offset Alley
([10] * 16).each do |obst_point|
  FactoryGirl.create :obstacle, point_value: obst_point, obstacle_type: 'cone',
    maneuver: maneuvers['Offset Alley']
end
maneuvers['Offset Alley'].update_attributes(counts_reverses: true,
                                            reverse_points: 10)

unless Rails.env.production? || ENV['SKIP_PARTICIPANTS']
  def random_boolean
    [true, false].sample
  end
  bus = FactoryGirl.create :bus
  10.times do |i|
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
      missed_turn_signals: rand(2), sudden_stops: rand(3), sudden_starts: rand(4), abrupt_turns: rand(3)
    WheelchairManeuver.create! participant: p, first_ask_to_touch: random_boolean,
      first_check_brakes_on: random_boolean, offer_seatbelt: random_boolean,
      securement: random_boolean, ask_if_ready: random_boolean, remove_restraints: random_boolean,
      check_brakes_off: random_boolean, second_ask_to_touch: random_boolean,
      second_check_brakes_on: random_boolean, ask_if_all_set_on_lift: random_boolean
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

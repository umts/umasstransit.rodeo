require 'factory_girl_rails'

exit if Rails.env.test?

man_names = ['Serpentine', 'Offset Street', 'Rear Dual Clearance', 'Right Turn',
 'Right Reverse', 'First Passenger Stop', 'Left Turn', 'Left Reverse',
 'Second Passenger Stop', 'Diminishing Clearance', 'Judgement Stop']

maneuvers = {}
  
man_names.each_with_index do |man_name, i|
  maneuvers[man_name] = FactoryGirl.create :maneuver,
                                           name: man_name, sequence_number: i
end

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

awesome_bus = FactoryGirl.create :bus, number: '3306'
not_so_awesome_bus = FactoryGirl.create :bus, number: '3312'
dave = FactoryGirl.create :participant, number: 1, bus: awesome_bus,
  name: 'David Faulkenberry'
FactoryGirl.create :participant, number: 2, bus: awesome_bus,
  name: 'Matt Moretti'
FactoryGirl.create :participant, number: 3, bus: awesome_bus,
  name: 'Adam Sherson'

FactoryGirl.create :maneuver_participant, maneuver: maneuvers['Serpentine'],
  participant: dave

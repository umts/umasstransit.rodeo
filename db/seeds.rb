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

([10] * 14 << 25).each do |obst_point|
  FactoryGirl.create :obstacle, maneuver: maneuvers['Serpentine'],
    point_value: obst_point
end


awesome_bus = FactoryGirl.create :bus, number: '3306'
not_so_awesome_bus = FactoryGirl.create :bus, number: '3312'
FactoryGirl.create :participant, number: 1, bus: awesome_bus,
  name: 'David Faulkenberry'
FactoryGirl.create :participant, number: 2, bus: awesome_bus,
  name: 'Matt Moretti'
FactoryGirl.create :participant, number: 3, bus: awesome_bus,
  name: 'Adam Sherson'

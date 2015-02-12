# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Day.create(name: 'Monday')
Day.create(name: 'Tuesday')
Day.create(name: 'Wednesday')
Day.create(name: 'Thursday')
Day.create(name: 'Friday')
Day.create(name: 'Saturday')
Day.create(name: 'Sunday')

Shiftslot.create(name: 'Morning')
Shiftslot.create(name: 'Afternoon')
Shiftslot.create(name: 'Evening')
Shiftslot.create(name: 'Night')

Category.create(vehicle: 'Motorcycle',
  name_of_user: 'Motorcycle rider',
  description: 'Motorcycles (and mopeds) are the lifeblood of the takeaway and courier industries. You can deliver most small parcels quickly with a motorcycle. Motorcyclists don’t pay London’s congestion charge. If your business needs a motorbike driver, you can use a get your items delivered quickly and easily. You can find a professional motorbike rider here. Just post a job today to start!'
)
Category.create(vehicle: 'Van',
  name_of_user: 'Van driver')
Category.create(vehicle: 'Lorry',
  name_of_user: 'Lorry driver')
Category.create(vehicle: 'Taxi',
  name_of_user: 'Taxi driver')
Category.create(vehicle: 'Car',
  name_of_user: 'Car driver')
Category.create(vehicle: 'Bus',
  name_of_user: 'Bus driver')
Category.create(vehicle: 'Push-bike',
  name_of_user: 'Push-bike cyclist')
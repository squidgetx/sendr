# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
College.create([{
  name: "Yale"
}, {
  name: "RIT"
}])

Climber.create([{
  name: "Ben Eskildsen",
  ccs_id: 2345324,
  college_id: 1
}, {
  name: "Sylvan Zheng",
  ccs_id: 2453421,
  college_id: 1
}, {
  name: "RIT guy",
  ccs_id: 239042,
  college_id: 2
}])

Comp.create([{
  state: "open",
  location: "Gravity Vault",
  date: Date.tomorrow,
}]);

Route.create([{
  comp_id: 1,
  name: "Predator",
  color: "orange",
  points: 1400,
  notes: "arete off",
  discipline: "sport",
  grade: "5.13b",
  location: "orange crush"
}, {
  comp_id: 1,
  name: "Black Jack Crack",
  color: "black",
  points: 1100,
  discipline: "boulder",
  grade: "V2",
  location: "Topout area"
}]);

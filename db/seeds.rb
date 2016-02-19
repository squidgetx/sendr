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
  ccs_id: 1,
  college_id: 1,
  gender: :male
}, {
  name: "Sylvan Zheng",
  ccs_id: 2,
  college_id: 1,
  gender: :male
}, {
  name: "RIT guy",
  ccs_id: 3,
  college_id: 2,
  gender: :male
}, {
  name: "Libby Henry",
  ccs_id: 4,
  college_id: 1,
  gender: :female
}, {
  name: "Grace Stonecipher",
  ccs_id: 5,
  college_id: 1,
  gender: :female
}

])

Comp.create([{
  state: :open,
  location: "Gravity Vault",
  date: Date.tomorrow,
}]);

Route.create([
{
  comp_id: 1,
  name: "Predator",
  color: "orange",
  points: 1400,
  notes: "arete off",
  discipline: :sport,
  grade: "5.13b",
  location: "orange crush"
},
{
  comp_id: 1,
  name: "Amarillo Sunset",
  color: "yellow",
  points: 1100,
  notes: "must do all moves static",
  discipline: :sport,
  grade: "5.11a",
  location: "PMRP"
},
{
  comp_id: 1,
  name: "Pure Imagination",
  color: "red",
  points: 1550,
  notes: "Sasha DiGiulian",
  discipline: :sport,
  grade: "5.14d",
  location: "The Motherlode"
},
{
  comp_id: 1,
  name: "Iron Cross",
  color: "grey",
  points: 1350,
  discipline: :boulder,
  grade: "V4",
  location: "Lincoln Woods"
},
{
  comp_id: 1,
  name: "Black Jack Crack",
  color: "black",
  points: 1100,
  discipline: :boulder,
  grade: "V2",
  location: "Topout area"
},
]);

Scoresheet.create({
  comp_id: 1,
  climber_id: 1
})

Climb.create([{
  scoresheet_id: 1,
  route_id: 1
}])

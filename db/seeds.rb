# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


airports = Airport.create([
  { code: "TAC", city: "Tacloban" },
  { code: "MNL", city: "Manila" },
  { code: "DVO", city: "Davao" },
  { code: "CEB", city: "Cebu" },
  { code: "PPS", city: "Puerto Princesa" },
  { code: "TAG", city: "Tagbilaran" },
  { code: "LAO", city: "Laoag" },
  { code: "CRK", city: "Clark" },
  { code: "BWN", city: "Bacolod" },
  { code: "ORM", city: "Ormoc" },
  { code: "ILO", city: "Iloilo" },
  { code: "KLO", city: "Kalibo" },
  { code: "DGT", city: "Dumaguete" },
  { code: "ZAM", city: "Zamboanga" },
  { code: "SJI", city: "San Jose" }
])


today = Date.today
month_from_today = Date.today + 20

(today..month_from_today).each do |date|
  FlightGenerator.call(date)
end


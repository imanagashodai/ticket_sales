# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

User.delete_all
Ground.delete_all
Blockeduser.delete_all
Seatgroup.delete_all
Team.delete_all
Seat.delete_all
Game.delete_all
Ticket.delete_all
Cart.delete_all
Purchase.delete_all


CSV.foreach('db/table_user.csv', headers: true) do |row|
  User.create(id: row[0], name: row[1], email: row[2], password: row[3], password_confirmation: row[4], admin: row[5])
end

CSV.foreach('db/table_ground.csv', headers: true) do |row|
  Ground.create(id: row[0], name: row[1])
end

CSV.foreach('db/table_blockeduser.csv', headers: true) do |row|
  Blockeduser.create(id: row[0], user_id: row[1])
end

CSV.foreach('db/table_seatgroup.csv', headers: true) do |row|
  Seatgroup.create(id: row[0], name: row[1], ground_id: row[2], price: row[3])
end

CSV.foreach('db/table_team.csv', headers: true) do |row|
  Team.create(id: row[0], name: row[1], ground_id: row[2])
end

CSV.foreach('db/table_seat.csv', headers: true) do |row|
  Seat.create(id: row[0], seatgroup_id: row[1], name: row[2])
end

CSV.foreach('db/table_game.csv', headers: true) do |row|
  Game.create(id: row[0], datetime: "#{row[1]}-#{row[2]}-#{row[3]} #{row[4]}:#{row[5]}", hometeam_id: row[6], visitorteam_id: row[7], ground_id: row[8])
end

CSV.foreach('db/table_ticket.csv', headers: true) do |row|
  Ticket.create(id: row[0], game_id: row[1], seat_id: row[2])
end

CSV.foreach('db/table_cart.csv', headers: true) do |row|
  Cart.create(id: row[0], ticket_id: row[1], user_id: row[2])
end

CSV.foreach('db/table_purchase.csv', headers: true) do |row|
  Purchase.create(id: row[0], ticket_id: row[1], user_id: row[2])
end
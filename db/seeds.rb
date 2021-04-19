# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

# User.destroy_all
# User.create(id: 0, name: "管理人", email: "admin@admin.admin", password: "adminadmin1", password_confirmation: "adminadmin1" , admin: true)

# Game.destroy_all
# CSV.foreach('db/table_game.csv') do |row|
#   Game.create(id: row[0], datetime: "#{row[1]}-#{row[2]}-#{row[3]} #{row[4]}:#{row[5]}", hometeam_id: row[6], visitorteam_id: row[7], ground_id: row[8])
# end

# Ground.destroy_all
# CSV.foreach('db/table_ground.csv') do |row|
#   Ground.create(id: row[0], name: row[1])
# end

# Seatgroup.destroy_all
# CSV.foreach('db/table_seatgroup.csv') do |row|
#   Seatgroup.create(id: row[0], name: row[1], ground_id: row[2], price: row[3])
# end

# Seat.destroy_all
# CSV.foreach('db/table_seat.csv') do |row|
#   Seat.create(id: row[0], seatgroup_id: row[1], name: row[2])
# end

Ticket.destroy_all
CSV.foreach('db/table_ticket.csv') do |row|
  Ticket.create(id: row[0], game_id: row[1], seat_id: row[2])
end

# Team.destroy_all
# CSV.foreach('db/table_team.csv') do |row|
#   Team.create(id: row[0], name: row[1], ground_id: row[2])
# end


# Seat.destroy_all
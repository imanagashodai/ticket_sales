# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

User.destroy_all
User.create(id: 0, name: 管理人, email: "q", password: "q", password_confirmation: "q")

Game.destroy_all
CSV.foreach('db/table_game.csv') do |row|
  Game.create(id: row[0], date: row[1], start: row[2], home_id: row[3], visitor_id: row[4], ground_id: row[5])
end

Ground.destroy_all
CSV.foreach('db/table_ground.csv') do |row|
  Ground.create(id: row[0], name: row[1])
end

Seatgroup.destroy_all
CSV.foreach('db/table_seatgroup.csv') do |row|
  Seatgroup.create(id: row[0], name: row[1], ground_id: row[2])
end

Team.destroy_all
CSV.foreach('db/table_team.csv') do |row|
  Team.create(id: row[0], name: row[1])
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'


csv_text = File.read(Rails.root.join('lib', 'seeds', 'buildings.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Building.new
  t.name = row['Building']
  t.misc = row['Misc']
  t.lng = row['Longitude']
  t.lat = row['Latitude']
  t.save
end

file_names = ['rooms_central.csv', 'rooms_south.csv', 'rooms_west.csv', 'rooms_north.csv']

file_names.each do |filename|
  csv_text = File.read(Rails.root.join('lib', 'seeds', filename))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Room.new
    t.building_id = Building.where("name = :name", {name: row['Location']})[0].id
    t.number = row['Classroom #']
    t.capacity = row['Capacity']
    t.facilities = row['Feature']
    t.misc = row['Categories']
    t.save
    puts "#{t.building_id}, #{t.capacity} saved"
  end
end

puts "There are now #{Building.count} rows in the Building table"
puts "There are now #{Room.count} rows in the Room table"


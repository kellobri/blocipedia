require 'faker'

admin = User.new(
	name: 'Admin Kelly',
	email: 'kellyobriant@gmail.com',
	password: 'blocparty',
	role: 'admin'
	)
admin.save!

kellystandard = User.new(
	name: 'Standard Kelly',
	email: 'kobriant@gmu.edu',
	password: 'blocparty'
	)
kellystandard.save!

5.times do
	user = User.new(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: Faker::Lorem.characters(10)
		)
	user.save!
end
users = User.all

15.times do 
	Wiki.create!(
		user: users.sample,
		created_by: 'seed machine',
		last_update_at: Time.zone.now, 
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraph

	)
end

puts "Seed finished"
puts "#{User.count} users are now in the system."
puts "#{Wiki.count} wiki pages have been seeded."
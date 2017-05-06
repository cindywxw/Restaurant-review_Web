# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.delete_all
Table.delete_all
Openhour.delete_all
User.delete_all
Administrator.delete_all
Reservation.delete_all

restaurants = [["Valois","1518 E 53rd St, Chicago, IL, 60615",10],
        	   ["Alinea","1723 N Halsted St, Chicago, IL, 60614",10],
       		   ["Joe's Seafood","60 E Grand Ave, Chicago, IL, 60611",8],
        	   ["El Taco Azteca","2151 W Cermak Rd, Chicago, IL, 60609",5],
        	   ["Wildberry Pancakes","130 E Randolph St, Chicago, IL, 60601",9]]

["Cookie Monster", "Abraham Lincoln", "Luke Skywalker", "Harry Potter",
"Mary Poppins", "Dorothy Gale", "Luna Lovegood"].each do |name|
  User.create name: name, password: "123456", points: 0
end

["Justin Bieber", "Taylor Swift"].each do |name|
  Administrator.create name: name, password: "123456"
end

numbers = ["2", "4", "6", "8", "10"]

restaurants.each do |entry|
	rest = Restaurant.new
	rest.name = entry[0]
	rest.address = entry[1]
	rest.table_number = entry[2]
	rest.save
	(entry[2]+1).times do |t|
		Table.create restaurant: rest, table_order: t, capacity: numbers.sample
	end 
	Reservation.create restaurant: rest, guest: User.sample, people: Table.last.capacity, reserve_at: (Time.now - 2.days).utc.to_s(:db), dine_at: (Time.now - 1.days).utc.to_s(:db)
	Review.create restaurant: rest, reviewer: Reservation.last.guest, content: "Yummy!", updated_at: Time.now.utc.to_s(:db)
	u = User.find_by(id: Reservation.last.guest)
	newpoint = u.points + 10
	u.update points: newpoint
end



puts "There are now:"
puts "  #{Restaurant.count} restaurants"
puts "  #{User.count} user accounts"
puts "  #{Administrator.count} administrator accounts"
puts "  #{Reservation.count} reservations"
puts "  #{Review.count} reviews"

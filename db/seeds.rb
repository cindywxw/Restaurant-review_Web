# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.delete_all
Table.delete_all
User.delete_all
Reservation.delete_all
Review.delete_all

restaurants = [["Valois","1518 E 53rd St, Chicago, IL 60615",10],
        	   ["Alinea","1723 N Halsted St, Chicago, IL 60614",10],
       		   ["Joe's Seafood","60 E Grand Ave, Chicago, IL 60611",8],
        	   ["El Taco Azteca","2151 W Cermak Rd, Chicago, IL 60609",5],
        	   ["Girl & the Goat","809 W Randolph St, Chicago, IL 60607",6],
        	   ["Au Cheval","800 W Randolph St, Chicago, IL 60607",10],
        	   ["Lowcountry","3343 N Clark St, Chicago, IL 60657",7],
        	   ["The Purple Pig","500 N Michigan Ave, Chicago, IL 60611",10],
        	   ["The Crab Pad","2529 N Milwaukee Ave, Chicago, IL 60647",9],
        	   ["The Dearborn","145 N Dearborn St, Chicago, IL 60602",7],
        	   ["Giant","3209 W Armitage Ave, Chicago, IL 60647",4],
        	   ["Gather","4539 N Lincoln Ave, Chicago, IL 60625",8],
        	   ["Crisp","2940 N Broadway Ave, Chicago, IL 60657",10],
        	   ["Knife & Tine","1417 W Fullerton Ave, Chicago, IL 60614",7],
        	   ["Beatrix Streeterville","671 N St Clair, Chicago, IL 60611",9],
        	   ["Bavette’s Bar & Boeuf","218 W Kinzie St, Chicago, IL 60654",10],
        	   ["Spotted Monkey","335 S Franklin St, Chicago, IL 60606",5],
        	   ["Doc B’s Fresh Kitchen","100 E Walton St, Chicago, IL 60611", 6],
        	   ["Forbidden Root","1746 W Chicago Ave, Chicago, IL 60622", 4],
        	   ["Ella Elli","1349 W Cornelia Ave, Chicago, IL 60657",3],
        	   ["Little Bad Wolf","1541 W Bryn Mawr Ave, Chicago, IL 60660",6],
        	   ["True Food Kitchen","1 W Erie St, Chicago, IL 60654",3],
        	   ["The Spice Room","2906 W Armitage Ave, Chicago, IL 60647",2],
        	   ["Quartino Ristorante","626 N State St, Chicago, IL 60654",10],
        	   ["Xoco","449 N Clark St, Chicago, IL 60654",10],
        	   ["Copper Fox Gastropub","155 East Ontario St, Chicago, IL 60611",4],
        	   ["Brightwok Kitchen","21 E Adams St, Chicago, IL 60603",5],
        	   ["The Region","2057 W Roscoe St, Chicago, IL 60618",2],
        	   ["The Gage","24 S Michigan Ave, Chicago, IL 60603",9],
        	   ["Arbella","112 West Grand Ave, Chicago, IL 60654",3],
        	   ["Three Dots and a Dash","435 N Clark St, Chicago, IL 60654",7],
        	   ["Home Bistro","3404 N Halsted St, Chicago, IL 60657",5],
        	   ["Bandera Restaurant","535 N Michigan Ave, Chicago, IL 60611",6],
        	   ["Avec","615 W Randolph St, Chicago, IL 60661",8],
        	   ["Penumbra Wine Bar","3309 W Fullerton Ave, Chicago, IL 60647",2],
        	   ["Summer House Santa Monica","1954 N Halsted St, Chicago, IL 60614",8],
        	   ["Patino’s Grill","2943 W Irving Park Rd, Chicago, IL 60618",1],
        	   ["T & B Grill","3658 W Lawrence Ave, Chicago, IL 60625",2],
        	   ["En Hakkore","1840 N Damen Ave, Chicago, IL 60647", 4],
        	   ["Bohemian House","11 W Illinois St, Chicago, IL 60654",4],
        	   ["Mother Cluckers Kitchen","5200 N Elston Ave, Chicago, IL 60630",5],
        	   ["Cafecito","215 E Chestnut St, Chicago, IL 60611",2],
        	   ["Saucy Porka","400 S Financial Pl, Chicago, IL 60605",4],
        	   ["Lawrence Fish Market","3800 N Pulaski Rd, Chicago, IL 60641",6],
        	   ["Smoque BBQ","3800 N Pulaski Rd, Chicago, IL 60641",10],
        	   ["Wildberry Pancakes","130 E Randolph St, Chicago, IL, 60601",10]]

["Cookie Monster", "Abraham Lincoln", "Luke Skywalker", "Harry Potter","Indiana Jones",
"Mary Poppins", "Dorothy Gale", "Luna Lovegood"].each do |name|
  email_address = name.split.first.downcase + "@tinytable.com"
  lame_password = name.split.first.downcase
  User.create name: name, email: email_address, password: lame_password, points: 0
end

["Justin Bieber", "Taylor Swift"].each do |name|
  email_address = name.split.first.downcase + "@tinytable.com"
  lame_password = name.split.first.downcase
  User.create name: name, email: email_address, password: lame_password, points: 0, admin: true
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
	Reservation.create restaurant: rest, guest: User.sample, people: Table.last.capacity, reserve_at: (Time.current - 2.days).utc.to_s(:db), dine_at: (Time.current - 1.days).utc.to_s(:db)
	# puts Time.zone
	# puts (Time.current - 2.days).zone.to_s
	Review.create restaurant: rest, reviewer: Reservation.last.guest, content: "Yummy!", updated_at: Time.current.utc.to_s(:db)
	u = User.find_by(id: Reservation.last.guest)
	newpoint = u.points + 10
	u.points = newpoint
	u.save(validate: false)
end



puts "There are now:"
puts "  #{Restaurant.count} restaurants"
puts "  #{User.count} user accounts"
puts "  #{Reservation.count} reservations"
puts "  #{Review.count} reviews"

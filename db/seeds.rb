10.times do
	
	@survivor = Survivor.create({
		name: Faker::Name.name,
		age: Faker::Number.between(0, 90),
		gender: Faker::Gender.binary_type,
		latitude: Faker::Address.latitude,
		longitude: Faker::Address.longitude,
		water: Faker::Number.between(0, 20),
		food: Faker::Number.between(0, 20),
		medication: Faker::Number.between(0, 20),
		ammunition: Faker::Number.between(0, 20),
		infected: Faker::Number.between(0, 4)
	})

end
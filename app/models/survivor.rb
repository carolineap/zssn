class Survivor < ApplicationRecord

	validates :name, :age, :gender, :latitude, :longitude, :water, :medication, :food, :ammunition, presence: true

	def is_infected?
		self.infected >= 3
	end

	def enough_items?(water, food, medication, ammunition)
		self.water >= water.to_i and self.food >= food.to_i and self.medication >= medication.to_i and self.ammunition >= medication.to_i
	end

	def trade(water1, food1, medication1, ammunition1, water2, food2, medication2, ammunition2)
		return { 'water' => self.water - water1 + water2, 'food' => self.food - food1 + food2, 'medication' => self.medication - medication1 + medication2, 'ammunition' => ammunition - ammunition1 + ammunition2 }
	end


end
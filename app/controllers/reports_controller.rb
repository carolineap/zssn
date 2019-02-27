class ReportsController < ApplicationController

  	def infected_survivors
    	 	render json: {'infected_survivors': String(get_infected_survivors.round(2))+'%'}
  	end

    def non_infected_survivors
      render json: {'non_infected_survivors': String(100 - get_infected_survivors.round(2))+'%'}
    end

    def average_resources
      water, food, medication, ammunition = average
      render json: {'water': water.round(2), 'food': food.round(2), 'medication': medication.round(2), 'ammunition': ammunition.round(2)}
    end

    def points_lost
      render json: {'points_lost': get_points_lost}
    end

  	private
  	def get_infected_survivors
  		(Survivor.where("infected >= ?", 3).count*100)/Survivor.count 
  	end

  	private 
  	def get_points_lost
  		points = 0
  		Survivor.where("infected >= ?", 3).each do |survivor|
  			points = points + survivor.water*4 + survivor.food*3 + survivor.medication*2 + survivor.ammunition
  		end
  		return points
  	end

  	private
  	def average
  		water = food = medication = ammunition = 0
  		Survivor.where("infected < ?", 3).each do |survivor|
  			water = water + survivor.water
  			food = food + survivor.food
  			medication = medication + survivor.medication
  			ammunition = ammunition + survivor.ammunition
  		end
  		n = Float(Survivor.where("infected < ?", 3).count)
  		return water/n, food/n, medication/n, ammunition/n
  	end

end

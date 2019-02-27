class SurvivorsController < ApplicationController
  
  before_action :set_survivor, only: [:update, :show]

  # GET /survivors
  def index
    @survivors = Survivor.where("infected < ?", 3)
    render json: @survivors
  end

  # GET /survivors/1
  def show
    if @survivor.present? and not @survivor.infected?
      render json: @survivor, status: :ok
    else
      render json: {"message": "can not show infected survivor"}, status: :forbidden
    end
  end

  # POST /survivors
  def create

      @survivor = Survivor.new(survivor_params)

      if @survivor.save
        render json: @survivor, status: :created, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
  end


  # PATCH/PUT /survivors/1
  def update
      if not @survivor.is_infected? and survivor_update_params.present? and @survivor.update(survivor_update_params)
        render status: :no_content
      elsif @survivor.is_infected?
        render json: {"message": "infected survivor can not update location"}, status: :forbidden
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
  end


  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude).merge(infected: 0).merge(params.require(:survivor).require(:inventory).permit(:water, :food, :medication, :ammunition))
    end

    def survivor_update_params
      params.require(:location).permit(:latitude, :longitude)
    end

end

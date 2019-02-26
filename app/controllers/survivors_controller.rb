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
    elsif @survivor.present?
      render status: :forbidden
    else
      render status: :forbidden
    end
  end

  # POST /survivors
  def create

    if params.has_key?("inventory")

      @survivor = Survivor.new(survivor_params)

      if @survivor.save
        render json: @survivor, status: :created, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end

    else
        render status: :unprocessable_entity
    end

  end


  # PATCH/PUT /survivors/1
  def update
      if not @survivor.is_infected? and survivor_update_params.present? and @survivor.update(survivor_update_params)
        render json: @survivor,status: :no_content
      elsif @survivor.is_infected?
        render status: :forbidden
      elsif not survivor_update_params.present?
        render status: :bad_request
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.permit(:name, :age, :gender, :latitude, :longitude).merge(infected: 0).merge(params.require(:inventory).permit(:water, :food, :medication, :ammunition))
    end

    def survivor_update_params
      params.permit(:latitude, :longitude)
    end

end

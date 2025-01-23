class CharacteristicsController < ApplicationController
  before_action :set_characteristic, only: %i[ show update destroy ]

  # GET /characteristics
  def index
    @characteristics = Characteristic.all

    render json: @characteristics
  end

  # GET /characteristics/1
  def show
    render json: @characteristic
  end

  # POST /characteristics
  def create
    @characteristic = Characteristic.new(characteristic_params)

    if @characteristic.save
      render json: @characteristic, status: :created, location: @characteristic
    else
      render json: @characteristic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characteristics/1
  def update
    if @characteristic.update(characteristic_params)
      render json: @characteristic
    else
      render json: @characteristic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characteristics/1
  def destroy
    @characteristic.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_characteristic
      @characteristic = Characteristic.find_by(id: params[:id])
      render json: { error: "characteristic not found" }, status: :not_found unless @characteristic
    end

    # Only allow a list of trusted parameters through.
    def characteristic_params
      params.expect(characteristic: [ :category_id, :name, :description, :required, :active ])
    end
end

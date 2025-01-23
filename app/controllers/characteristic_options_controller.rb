class CharacteristicOptionsController < ApplicationController
  before_action :set_characteristic_option, only: %i[ show update destroy ]

  # GET /characteristic_options
  def index
    @characteristic_options = CharacteristicOption.all

    render json: @characteristic_options
  end

  # GET /characteristic_options/1
  def show
    render json: @characteristic_option
  end

  # POST /characteristic_options
  def create
    @characteristic_option = CharacteristicOption.new(characteristic_option_params)

    if @characteristic_option.save
      render json: @characteristic_option, status: :created, location: @characteristic_option
    else
      render json: @characteristic_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characteristic_options/1
  def update
    if @characteristic_option.update(characteristic_option_params)
      render json: @characteristic_option
    else
      render json: @characteristic_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characteristic_options/1
  def destroy
    @characteristic_option.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_characteristic_option
      @characteristic_option = CharacteristicOption.find_by(id: params[:id])
      render json: { error: "characteristic_option not found" }, status: :not_found unless @characteristic_option
    end

    # Only allow a list of trusted parameters through.
    def characteristic_option_params
      params.expect(characteristic_option: [ :characteristic_id, :name, :description, :price_adjustment, :in_stock ])
    end
end

class ItemCharacteristicsController < ApplicationController
  before_action :set_item_characteristic, only: %i[ show update destroy ]

  # GET /item_characteristics
  def index
    @item_characteristics = ItemCharacteristic.all

    render json: @item_characteristics
  end

  # GET /item_characteristics/1
  def show
    render json: @item_characteristic
  end

  # POST /item_characteristics
  def create
    @item_characteristic = ItemCharacteristic.new(item_characteristic_params)

    if @item_characteristic.save
      render json: @item_characteristic, status: :created, location: @item_characteristic
    else
      render json: @item_characteristic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_characteristics/1
  def update
    if @item_characteristic.update(item_characteristic_params)
      render json: @item_characteristic
    else
      render json: @item_characteristic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_characteristics/1
  def destroy
    @item_characteristic.destroy!
  end

  # GET /item_characteristics/by_item/:item_id
  def characteristics_by_item
    @item_characteristics = ItemCharacteristic.where(item_id: params[:item_id])

    if @item_characteristics.any?
      render json: @item_characteristics
    else
      render json: { error: "No characteristics found for the given item" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_characteristic
      @item_characteristic = ItemCharacteristic.find_by(id: params[:id])
      render json: { error: "item_characteristic not found" }, status: :not_found unless @item_characteristic
    end

    # Only allow a list of trusted parameters through.
    def item_characteristic_params
      params.expect(item_characteristic: [ :item_id, :characteristic_id, :characteristic_option_id, :active ])
    end
end

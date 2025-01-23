class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]

  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  def show
      render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
  end

  # GET /items/by_category/:category_id
  def items_by_category
    @items = Item.where(category_id: params[:category_id])

    if @items.any?
      render json: @items
    else
      render json: { error: "No items found for the given category" }, status: :not_found
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find_by(id: params[:id])
      return render json: { error: "Item not found" }, status: :not_found unless @item
    end


    # Only allow a list of trusted parameters through.
    def item_params
      params.expect(item: [ :category_id, :name, :description, :base_price, :active ])
    end
end

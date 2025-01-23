class ItemImagesController < ApplicationController
  before_action :set_item_image, only: %i[ show update destroy ]

  # GET /item_images
  def index
    @item_images = ItemImage.all

    render json: @item_images
  end

  # GET /item_images/1
  def show
    render json: @item_image
  end

  # POST /item_images
  def create
    @item_image = ItemImage.new(item_image_params)

    if @item_image.save
      render json: @item_image, status: :created, location: @item_image
    else
      render json: @item_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_images/1
  def update
    if @item_image.update(item_image_params)
      render json: @item_image
    else
      render json: @item_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_images/1
  def destroy
    @item_image.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_image
      @item_image = ItemImage.find_by(id: params[:id])
      render json: { error: "item_image not found" }, status: :not_found unless @item_image
    end

    # Only allow a list of trusted parameters through.
    def item_image_params
      params.expect(item_image: [ :item_id, :url, :alt_text, :is_main, :display_order ])
    end
end

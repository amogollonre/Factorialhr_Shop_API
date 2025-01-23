class OptionImagesController < ApplicationController
  before_action :set_option_image, only: %i[ show update destroy ]

  # GET /option_images
  def index
    @option_images = OptionImage.all

    render json: @option_images
  end

  # GET /option_images/1
  def show
    render json: @option_image
  end

  # POST /option_images
  def create
    @option_image = OptionImage.new(option_image_params)

    if @option_image.save
      render json: @option_image, status: :created, location: @option_image
    else
      render json: @option_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /option_images/1
  def update
    if @option_image.update(option_image_params)
      render json: @option_image
    else
      render json: @option_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /option_images/1
  def destroy
    @option_image.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option_image
      @option_image = OptionImage.find_by(id: params[:id])
      render json: { error: "Option Image not found" }, status: :not_found unless @option_image
    end

    # Only allow a list of trusted parameters through.
    def option_image_params
      params.expect(option_image: [ :characteristic_option_id, :url, :alt_text, :is_main, :display_order ])
    end
end

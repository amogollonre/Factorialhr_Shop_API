class CategoryOptionRestrictionsController < ApplicationController
  before_action :set_category_option_restriction, only: %i[ show update destroy ]

  # GET /category_option_restrictions
  def index
    @category_option_restrictions = CategoryOptionRestriction.all

    render json: @category_option_restrictions
  end

  # GET /category_option_restrictions/1
  def show
    render json: @category_option_restriction
  end

  # POST /category_option_restrictions
  def create
    @category_option_restriction = CategoryOptionRestriction.new(category_option_restriction_params)

    if @category_option_restriction.save
      render json: @category_option_restriction, status: :created, location: @category_option_restriction
    else
      render json: @category_option_restriction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /category_option_restrictions/1
  def update
    if @category_option_restriction.update(category_option_restriction_params)
      render json: @category_option_restriction
    else
      render json: @category_option_restriction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /category_option_restrictions/1
  def destroy
    @category_option_restriction.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_option_restriction
      @category_option_restriction = CategoryOptionRestriction.find_by(id: params[:id])
      render json: { error: "category_option_restriction not found" }, status: :not_found unless @category_option_restriction
    end

    # Only allow a list of trusted parameters through.
    def category_option_restriction_params
      params.expect(category_option_restriction: [ :category_id, :if_characteristic_option_id, :then_characteristic_option_id, :restriction_type, :active ])
    end
end

class RestaurantsController < PanelController
  before_action :set_restaurant, only: %i[show edit update destroy]
  before_action :set_new_restaurant, only: %i[create]

  # GET /restaurants
  # GET /restaurants.json
  def index
    # @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show; end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit; end

  # POST /restaurants
  # POST /restaurants.json
  def create
    respond_to do |format|
      if @restaurant.save
        notice = 'Restaurant was successfully created. Please paste the Webhook url in Twilio.'
        format.html { redirect_to edit_restaurant_path(@restaurant), notice: notice }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def set_new_restaurant
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.users << current_user
  end

  # Only allow a list of trusted parameters through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :account_sid, :auth_token)
  end
end

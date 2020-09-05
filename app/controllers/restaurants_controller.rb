class RestaurantsController < PanelController
  include RestaurantUsers

  before_action :set_restaurant_user, only: %i[remove_user update_user]
  before_action :set_new_or_existing_user, only: %i[add_user]
  before_action :set_restaurant, only: %i[show edit update destroy add_user remove_user update_user]
  before_action :set_new_restaurant, only: %i[create]
  after_action :verify_authorized, only: %i[update destroy add_user remove_user update_user]

  # GET /restaurants
  # GET /restaurants.json
  def index
    # @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @orders = @restaurant.orders
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
    @users = @restaurant.users.includes(:roles)
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    respond_to do |format|
      if @restaurant.save
        current_user.add_role(:admin, @restaurant)
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
    authorize @restaurant
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to edit_restaurant_path(@restaurant), notice: 'Restaurant was successfully updated.' }
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
    authorize @restaurant
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /restaurants/1/add_user
  def add_user
    authorize @restaurant
    @restaurant_user.add_role :user, @restaurant
    respond_to do |format|
      format.json do
        restaurant_users_response
      end
    end
  end

  # POST /restaurants/1/remove_user
  def remove_user
    authorize @restaurant
    @restaurant_user.remove_all_roles(@restaurant)
    respond_to do |format|
      format.json do
        restaurant_users_response
      end
    end
  end

  # POST /restaurants/1/update_user
  def update_user
    authorize @restaurant
    respond_to do |format|
      if !@restaurant.others_admins?(@restaurant_user)
        format.json do
          render json: { error: { message: 'Minimum 1 Admin Required' } }, status: :forbidden
        end
      else
        @restaurant_user.change_role(params[:role].to_sym, @restaurant)
        format.json do
          restaurant_users_response
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id] || params[:id])
  end

  def set_new_restaurant
    @restaurant = Restaurant.new(restaurant_params)
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :phone_number, :address, :account_sid, :auth_token, :currency)
  end
end

class ItemsController < PanelController
  include ParseFile

  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_restaurant
  before_action :set_new_item, only: %i[create]
  after_action :verify_authorized, only: %i[create update destroy bulk_add]

  # GET /items
  # GET /items.json
  def index
    @items = @restaurant.items
  end

  # GET /items/1
  # GET /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items
  # POST /items.json
  def create
    authorize @restaurant

    respond_to do |format|
      if @item.save
        format.html { redirect_to restaurant_items_url(@restaurant), notice: 'Item was successfully added.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    authorize @restaurant

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to restaurant_items_url(@restaurant), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    authorize @restaurant

    @item.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_items_url(@restaurant), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bulk_add
    authorize @restaurant
    @new_items = create_items_from_file(params[:uploaded_file])

    respond_to do |format|
      if @new_items.any? { |item| item.errors.any? }
        format.html { render :new }
      else
        format.html { redirect_to restaurant_items_url(@restaurant), notice: 'Items were successfully added.' }
      end
    end
  end

  def sample_file
    send_file('public/restaurant_items.xlsx', filename: 'restaurant_items.xlsx')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  def set_new_item
    @item = @restaurant.items.new(item_params)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :cost, :category, :description, :cost_currency)
  end
end

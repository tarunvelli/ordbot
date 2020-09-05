class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :category, presence: true

  monetize :cost_cents

  def item_details
    {
      category: category,
      cost: cost.amount.to_f,
      display_cost: cost.format,
      description: description,
      id: id,
      name: name,
      restaurant_id: restaurant_id
    }
  end
end

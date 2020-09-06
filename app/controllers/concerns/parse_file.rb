# frozen_string_literal: true

module ParseFile
  extend ActiveSupport::Concern

  def create_items_from_file(file_data)
    xlsx = Roo::Spreadsheet.open(file_data.path)
    rows = xlsx&.parse(headers: true) || []
    rows = rows.reject.each_with_index { |_r, index| index.zero? }
    rows = rows.map do |r|
      r[:cost_currency] = @restaurant.currency
      r.transform_keys(&:downcase)
    end
    @restaurant.items.create(rows)
  end
end

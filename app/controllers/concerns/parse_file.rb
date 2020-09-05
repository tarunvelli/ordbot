# frozen_string_literal: true

module ParseFile
  extend ActiveSupport::Concern

  def create_items_from_file(file_data)
    xlsx = Roo::Spreadsheet.open(file_data.path)
    rows = xlsx&.parse(headers: true)&.map { |r| r.transform_keys(&:downcase) } || []
    rows = rows.reject.each_with_index { |_r, index| index.zero? }
    rows.each { |r| r[:cost_currency] = @restaurant.currency }
    @restaurant.items.create(rows)
  end
end

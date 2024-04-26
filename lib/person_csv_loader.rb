require_relative 'csv_reader'

class PersonCSVLoader < CSVReader
  def process_row(row)
    begin
      Person.create!(
        name: row['first_name']&.concat(row['last_name']),
        address: row['address']
      )
    rescue ActiveRecord::RecordInvalid => e
      @logger.error("Validation error for row: #{row.to_s}")
      @logger.error("Error message: #{e.message}")
    end
  end
end

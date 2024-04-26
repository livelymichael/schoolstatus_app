require 'csv'

class CSVReader
  attr_reader :file_path, :headers, :rows, :logger

  def initialize(file_path, logger, headers: true)
    @file_path = file_path
    @headers = headers
    @rows = []
    @logger = logger
  end

  def read
    begin
      CSV.foreach(@file_path, headers: @headers) do |row|
        process_row(row)
      end
    rescue StandardError => e
      handle_error(e)
    end
  end

  # To be overridden by child classes for custom row processing
  def process_row(row)
    raise NotImplementedError, "You must implement 'process_row' in a subclass"
  end

  def handle_error(error)
    @logger.error("Error: #{error.message}")
  end
end

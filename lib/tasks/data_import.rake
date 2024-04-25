require_relative '../../lib/person_csv_loader'

namespace :data_import do
  desc "Import data from CSV with custom logger and error handling"
  task import_person_csv: :environment do
    log_file_path = Rails.root.join("log/csv_import.log")

    unless File.exist?(log_file_path)
      File.open(log_file_path, 'w').close
    end

    custom_logger = Logger.new(log_file_path)

    custom_logger.info("Starting CSV data import")

    csv_file_path = Rails.root.join("people.csv")
    csv_loader = PersonCSVLoader.new(csv_file_path, custom_logger)
    csv_loader.read

    custom_logger.info("Completed CSV data import")
  end
end

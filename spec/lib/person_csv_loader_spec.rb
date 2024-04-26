require 'rails_helper'
require 'csv'
require 'tempfile'
require_relative '../../lib/person_csv_loader'

RSpec.describe PersonCSVLoader do
  let(:logger) { instance_double("Logger") }
  let(:valid_csv_content) { "first_name,last_name,address\nJohn,Doe,123 Main St\nJane,Doe,456 Oak St" }
  let(:missing_address_content) { "first_name,last_name,address\nJohn,Doe" }
  let(:missing_name_content) { "first_name,last_name,address\n,,123 Main St" }
  let(:temp_file) { Tempfile.new("test_csv") }

  before do
    allow(logger).to receive(:error)
  end

  after do
    temp_file.close
    temp_file.unlink
  end

  describe "#process_row" do
    it "creates Person records from valid CSV rows" do
      temp_file.write(valid_csv_content)
      temp_file.rewind

      loader = PersonCSVLoader.new(temp_file.path, logger, headers: true)
      loader.read

      expect(Person.count).to eq(2)
      expect(Person.first.name).to eq("JohnDoe")
    end

    it "logs an error for CSV rows with missing address" do
      temp_file.write(missing_address_content)
      temp_file.rewind

      loader = PersonCSVLoader.new(temp_file.path, logger, headers: true)
      loader.read

      expect(logger).to have_received(:error).with(/Validation error for row:/)
      expect(logger).to have_received(:error).with(/Error message: Validation failed: Address can't be blank/)
    end

    it "logs an error for CSV rows with missing name" do
      temp_file.write(missing_name_content)
      temp_file.rewind

      loader = PersonCSVLoader.new(temp_file.path, logger, headers: true)
      loader.read

      expect(logger).to have_received(:error).with(/Validation error for row:/)
      expect(logger).to have_received(:error).with(/Error message: Validation failed: Name can't be blank/)
    end
  end
end

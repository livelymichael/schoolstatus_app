require 'faraday'
require 'json'

class CensusService
  ACS_API_BASE_URL = "https://api.census.gov/data/2019/acs/acs5"  # ACS dataset

  def self.get_demographic_data(zip_code, state_code)
    query_string = "get=B01001_001E,B19013_001E&for=zip%20code%20tabulation%20area:#{zip_code}&in=state:#{state_code}"
    full_url = "#{ACS_API_BASE_URL}?#{query_string}"

    response = Rails.cache.fetch(zip_code) do
      Faraday.get(full_url)
    end

    if response.success? && response.body.present?
      JSON.parse(response.body)[1]
    else
      nil
    end
  end
end

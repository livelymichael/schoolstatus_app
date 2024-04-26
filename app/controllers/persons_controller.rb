class PersonsController < ApplicationController
  include StateCodeMapping

  before_action :set_person, only: %i[show]

  def index
    @persons = Person.page(params[:page]).per(8)
  end

  def show
    zip_code, state_code = parse_address

    @demographic_data = CensusService.get_demographic_data(zip_code, state_code)
  end

  private

  def person_params
    params.require(:person).permit(:name, :address)
  end

  def set_person
    @person = Person.find(params[:id])
  end

  def parse_address
    address_parts = @person.address.split(",").map(&:strip)
    state = address_parts[-2]  # State (e.g., "MS")

    [address_parts.last, get_state_code(state)]
  end
end

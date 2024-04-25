class PersonsController < ApplicationController
  before_action :set_person, only: %i[show]

  def index
    @persons = Person.all
  end

  def show
  end

  private

  def person_params
    params.require(:person).permit(:name, :address)
  end

  def set_person
    @person = Person.find(params[:id])
  end
end

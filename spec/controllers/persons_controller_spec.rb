require 'rails_helper'

RSpec.describe PersonsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns paginated persons to @persons" do
      create_list(:person, 10)
      get :index, params: { page: 1 }
      expect(assigns(:persons).count).to eq(8)
    end
  end

  describe "GET #show" do
    let(:person) { create(:person) }

    it "returns a success response for a valid person ID" do
      get :show, params: { id: person.id }
      expect(response).to be_successful
    end

    it "assigns the correct person to @person" do
      get :show, params: { id: person.id }
      expect(assigns(:person)).to eq(person)
    end

    it "fetches demographic data" do
      allow(CensusService).to receive(:get_demographic_data).and_return({ population: 1000 })
      get :show, params: { id: person.id }
      expect(assigns(:demographic_data)).to eq({ population: 1000 })
    end

    it "returns not found for an invalid person ID" do
      expect {
        get :show, params: { id: 999 }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

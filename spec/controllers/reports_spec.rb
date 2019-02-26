require 'rails_helper'

RSpec.describe "Survivors", type: :request do
 
  let!(:survivors) { create_list(:survivor, 8, water: 4, food:3, medication:2, ammunition: 1) }

  describe 'GET /reports/infected_survivors' do
    
    let!(:infected_survivors) { create_list(:survivor, 2, infected:3) }

    before { 
      get '/reports/infected_survivors' 
    }

    it 'returns infected survivors percentage' do
      expect(json).not_to be_empty
      expect(response).to have_http_status(200)
      expect(json['infected_survivors']).to eq("20%")
    end
   end

  describe 'GET /reports/non_infected_survivors' do

    context 'when there are infected survivors' do
      
      let!(:infected_survivors) { create_list(:survivor, 2, infected:3) }

      before { 
        get '/reports/non_infected_survivors' }

      it 'returns non infected survivors percentage' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(200)
        expect(json['non_infected_survivors']).to eq("80%")
      end
    end
   
    context 'when there are no infected survivors' do

      before { get "/reports/non_infected_survivors" }

      it 'returns non infected survivors percentage' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /reports/average_resources' do

    let!(:infected_survivors) { create_list(:survivor, 2, infected:3) } #this can not alter average 
    let!(:new_survivors) { create_list(:survivor, 8, water: 2, food:2, medication:2, ammunition: 2) }

    before { 
      get '/reports/average_resources' 
    }

    it 'returns average of resources' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(response).to have_http_status(200)
      expect(json['water']).to eq(3.0)
      expect(json['food']).to eq(2.5)
      expect(json['medication']).to eq(2.0)
      expect(json['ammunition']).to eq(1.5)
    end

  end

  describe 'GET /reports/points_lost' do

    let!(:infected_survivors) { create_list(:survivor, 10, water: 2, food:2, medication:2, ammunition: 2, infected: 3) }

    before { 
      get '/reports/points_lost' 
    }

    it 'returns average of resources' do
      expect(json).not_to be_empty
      expect(response).to have_http_status(200)
      expect(json['points_lost']).to eq(200)
    end

  end
  
end
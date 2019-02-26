# require 'rails_helper'

# RSpec.describe "Infected", type: :request do
 
#   let!(:survivor1) { create(:survivor, water: 1, food: 2, medication: 0, ammunition: 1)}
#   let(:survivor1_id) { survivor1.id }
#   let!(:survivor2) { create(:survivor, water: 3, food: 1, medication: 2, ammunition: 2)}
#   let(:survivor2_id) { survivor2.id }
#   let(:infected_survivor) { create(:survivor, infected: 4) }
#   let(:infected_survivor_id) { infected_survivor.id }

   # Test suite for POST /todos
  # describe 'POST /trade' do
    # valid payload
    # let(:valid_attributes) {{ items: [ { id: survivor1_id, food:2},{ id: survivor2_id, medication: 2, ammunition:2 }]}} 

    # context 'when the request is valid' do
    #   before { post '/survivors', params: valid_attributes }

      # it 'trade items from survivors' do
      #   expect(json[0]['water']).to eq(0)
      #   expect(json[0]['food']).to eq(0)
      #   expect(json[0]['medication']).to eq(2)
      #   expect(json[0]['ammunition']).to eq(1)
      #   expect(json[1]['water']).to eq(3)
      #   expect(json[1]['food']).to eq(3)
      #   expect(json[1]['medication']).to eq(0)
      #   expect(json[1]['ammunition']).to eq(0)
      # end

   #    it 'returns status code 200' do
   #      expect(response).to have_http_status(200)
   #    end
   #  end
   # end

    # context 'when the survivor is invalid' do
    #   #does not have medication
    #   let(:invalid_attributes) {{ name: "Jose", age: 25, gender: "Male", latitude: "0", longitude: "940", inventory: { water: 1, food: 5, ammunition: 0 }}} 

    #   before { post '/survivors', params: invalid_attributes }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end

    # end

    # context 'when the survivor does not have inventory' do

    #   let(:invalid_attributes) {{ age: 25, gender: "Male", latitude: "0", longitude: "940"}} 

    #   before { post '/survivors', params: invalid_attributes }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end
      
   
#end
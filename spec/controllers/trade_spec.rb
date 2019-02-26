require 'rails_helper'

RSpec.describe "Infected", type: :request do
 
  let!(:survivor1) { create(:survivor, water: 1, food: 2, medication: 0, ammunition: 1)}
  let(:survivor1_id) { survivor1.id }
  let!(:survivor2) { create(:survivor, water: 3, food: 1, medication: 2, ammunition: 2)}
  let(:survivor2_id) { survivor2.id }
  let(:infected_survivor) { create(:survivor, infected: 4) }
  let(:infected_survivor_id) { infected_survivor.id }

  # Test suite for POST /todos
  describe 'POST /trade' do
    
    context 'when the request is valid' do
      
      let(:valid_attributes) {{ items: [ { id: survivor1_id, food: 2}, {id: survivor2_id, medication: 2, ammunition:2 }]}} 
      
      before { post '/trade', params: valid_attributes }

      it 'trade items from survivors' do
        expect(json['survivor_1']['water']).to eq(1)
        expect(json['survivor_1']['food']).to eq(0)
        expect(json['survivor_1']['medication']).to eq(2)
        expect(json['survivor_1']['ammunition']).to eq(3)
        expect(json['survivor_2']['water']).to eq(3)
        expect(json['survivor_2']['food']).to eq(3)
        expect(json['survivor_2']['medication']).to eq(0)
        expect(json['survivor_2']['ammunition']).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request the items are not equivalent' do
      
      let(:invalid_attributes) {{ items: [ { id: survivor1_id, food: 3}, {id: survivor2_id, medication: 2, ammunition:2 }]}} 
      
      before { post '/trade', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when survivor does not exist' do
      
      let(:survivor2_id) { 100 }
      let(:invalid_attributes) {{ items: [ { id: survivor1_id, food: 3}, {id: survivor2_id, medication: 2, ammunition:2 }]}} 
      
      before { post '/trade', params: invalid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when id is not given' do
      
      let(:invalid_attributes) {{ items: [ { food: 3}, {medication: 2, ammunition:2 }]}} 
      
      before { post '/trade', params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when survivor is infected' do
      
      let(:invalid_attributes) {{ items: [ {id: survivor1_id, food: 3}, {id: infected_survivor_id, medication: 2, ammunition:2 }]}} 
      
      before { post '/trade', params: invalid_attributes }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when at least one of the survivors does not have enough resources' do
      
      let(:invalid_attributes) {{ items: [ {id: survivor1_id, food: 3}, {id: survivor2_id, medication: 1, ammunition:4 }]}} 
      
      before { post '/trade', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

   end
   
end
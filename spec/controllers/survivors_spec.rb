require 'rails_helper'

RSpec.describe "Survivors", type: :request do
 
  let!(:survivors) { create_list(:survivor, 10) }
  let!(:survivor) { create(:survivor)}
  let(:survivor_id) { survivor.id }
  let(:infected_survivor) { create(:survivor, infected: 4) }
  let(:infected_survivor_id) { infected_survivor.id }


  # Test suite for GET /survivors
  describe 'GET /survivors' do
    # make HTTP get request before each example

    before { get '/survivors' }

    it 'returns survivors' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
     
      expect(response).to have_http_status(200)
    end
   end

  #   it 'returns status code 200' do
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # Test suite for GET /todos/:id
  describe 'GET /survivors/:id' do

    context 'when the record exists' do

      before { get "/survivors/#{survivor_id}" }

      it 'returns the survivor' do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(survivor_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
   

    context 'when the record does not exist' do

      let(:survivor_id) { 100 }
      before { get "/survivors/#{survivor_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      
    end

    context 'when the record is infected' do
      
      before { get "/survivors/#{infected_survivor_id}" }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      
    end

  end

  # Test suite for POST /todos
  describe 'POST /survivors' do
    # valid payload
    let(:valid_attributes) {{ name: "José", age: 25, gender: "Male", latitude: "0", longitude: "940", inventory: { water: 1, food: 5, medication: 0, ammunition: 0 }}} 

    context 'when the request is valid' do
      before { post '/survivors', params: valid_attributes }

      it 'creates a survivor' do
        expect(json['name']).to eq('José')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the survivor is invalid' do
      #does not have medication
      let(:invalid_attributes) {{ name: "Jose", age: 25, gender: "Male", latitude: "0", longitude: "940", inventory: { water: 1, food: 5, ammunition: 0 }}} 

      before { post '/survivors', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end

    context 'when the survivor does not have inventory' do

      let(:invalid_attributes) {{ age: 25, gender: "Male", latitude: "0", longitude: "940"}} 

      before { post '/survivors', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      
    end
  end

  # Test suite for PUT /survivors/:id
  describe 'PUT PATCH/survivors/:id' do
    
    let(:valid_attributes) { { latitude: '1234', longitude: '5432' } }

    context 'when the survivors exists' do
      before { put "/survivors/#{survivor_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the survivors is infected' do

      before { patch "/survivors/#{infected_survivor_id}", params: valid_attributes }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when wrong parameter is passed' do

      let(:invalid_attributes) { { water: '4'} }

      before { put "/survivors/#{survivor_id}", params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

    end

    context 'when the survivors does not exist' do

      let(:survivor_id) { 100 }
      before { patch "/survivors/#{survivor_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

  end

  # # Test suite for DELETE /todos/:id
  # describe 'DELETE /todos/:id' do
  #   before { delete "/todos/#{todo_id}" }

  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  
end
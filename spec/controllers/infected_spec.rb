require 'rails_helper'

RSpec.describe "Infected", type: :request do
 
  let!(:survivor) { create(:survivor) }
  let!(:survivor_id) { survivor.id }

  describe 'POST /infected/:id' do

    context 'when survivor exist' do
      
      let(:valid_attributes) {{ id: survivor_id }}

      before { post "/infected", params: valid_attributes}

      it 'increment infected flag' do
        expect(response).to have_http_status(200)
        expect(survivor.reload.infected).to eq(1)
      end
    end
  
   
    context 'when survivor does not exist' do

      let(:invalid_attributes) {{ id: 100 }}

      before { post "/infected/", params: invalid_attributes}

      it 'return not found' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when param is not given' do

      before { post "/infected"}

      it 'id does not exist' do
        expect(response).to have_http_status(400)
      end
    end


    context 'when param does not have id key' do

      let(:invalid_attributes) {{ survivor: 100 }}

      before { post "/infected", params: invalid_attributes}

      it 'id does not exist' do
        expect(response).to have_http_status(400)
      end
    end

  end

end
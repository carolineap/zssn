require 'rails_helper'

RSpec.describe "Infected", type: :request do
 
  let!(:survivor) { create(:survivor) }
  let!(:survivor_id) { survivor.id }

  describe 'PUT /infected/:id' do

    context 'when survivor exist' do
      
      before { put "/infected/#{survivor_id}" }

      it 'increment infected flag' do
        expect(response).to have_http_status(200)
        expect(survivor.reload.infected).to eq(1)
      end
    end
  
   
    context 'when there are no infected survivors' do

      let(:survivor_id) { 100 }

      before { put "/infected/#{survivor_id}" }

      it 'return not found' do
        expect(response).to have_http_status(404)
      end
    end
  end

end
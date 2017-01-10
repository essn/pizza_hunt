require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe '#index' do
    def do_request
      get :index, params
    end

    describe 'json' do
      let(:query) { 'query' }
      let(:search_result) { 'reviews' }
      let(:params) do
        { xhr: true, format: :js, params: { search: { q: query } } }
      end

      before do
        allow(YelpPizzaScraper).to receive(:search).and_return(search_result)
      end

      it 'searches yelp' do
        expect(YelpPizzaScraper).to receive(:search).with(query)

        do_request
      end

      it 'assigns reviews instance variable to search result' do
        do_request

        expect(assigns[:reviews]).to eq(search_result)
      end
    end
  end
end

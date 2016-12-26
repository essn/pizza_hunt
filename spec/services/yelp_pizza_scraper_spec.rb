require 'rails_helper'

RSpec.describe YelpPizzaScraper do
  let(:scraper) { YelpPizzaScraper.new('query') }

  context 'intizialization' do
    describe 'parameters' do
      it 'accepts a single argument' do
        expect { YelpPizzaScraper.new(1, 2) }.to raise_error(ArgumentError)
      end

      it 'assigns query' do
        expect(scraper.query).to eq('query')
      end
    end
  end
end

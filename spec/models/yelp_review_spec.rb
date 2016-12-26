require 'rails_helper'

class Dummy
  def at(*args)
    nil
  end

  def [](*args)
    nil
  end
end

class DummyReview < Dummy; end
class DummyRestaurantPage < Dummy; end

RSpec.describe YelpReview do
  let(:review) { do_call }

  let(:options) do
    {
      data_review_id: 'data_review_id',
      user_href: 'user_href',
      yelp_biz_id: 'yelp_biz_id'
    }
  end

  context 'initialization' do
    def do_call
      YelpReview.new(options)
    end

    describe 'parameters' do
      it 'accepts a single argument' do
        expect { YelpReview.new(1, 2) }.to raise_error(ArgumentError)
      end

      describe 'assignment' do
        it 'assigns data_review_id' do
          expect(review.data_review_id).to eq options[:data_review_id]
        end

        it 'assigns user_href' do
          expect(review.user_href).to eq options[:user_href]
        end

        it 'assigns yelp_biz_id' do
          expect(review.yelp_biz_id).to eq options[:yelp_biz_id]
        end
      end
    end
  end

  describe '.build_from_review' do
    let(:dummy_review) { DummyReview.new }
    let(:dummy_page) { DummyRestaurantPage.new }

    def do_call
      YelpReview.build_from_review_and_page(dummy_review, dummy_page)
    end

    it 'calls new' do
      expect(YelpReview).to receive(:new)

      do_call
    end

    it 'returns an instance of YelpReview' do
      expect(do_call).to be_an_instance_of(YelpReview)
    end

    context 'item is not in response page' do
      it 'sets item to nil' do
        expect(do_call.data_review_id).to eq nil
      end
    end
  end
end

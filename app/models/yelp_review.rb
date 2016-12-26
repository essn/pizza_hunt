class YelpReview
  attr_accessor :data_review_id,
                :user_href,
                :yelp_biz_id,
                :user_display_name,
                :yelp_biz_name,
                :yelp_biz_href

  def initialize(options = {})
    @data_review_id = options[:data_review_id]
    @user_href = options[:user_href]
    @yelp_biz_id = options[:yelp_biz_id]
    @user_display_name = options[:user_display_name]
    @yelp_biz_name = options[:yelp_biz_name]
    @yelp_biz_href = options[:yelp_biz_href]
  end

  def self.build_from_review_and_page(review, restaurant_page)
    options = {
      data_review_id: allow_nil_for { review[:'data-review-id'] },
      user_display_name: allow_nil_for { review.at('a.user-display-name').text },
      user_href: allow_nil_for { review.at('a.user-display-name')[:href] },
      yelp_biz_id: allow_nil_for { restaurant_page.at("meta[name='yelp-biz-id']")[:content] },
      yelp_biz_name: allow_nil_for { restaurant_page.at('h1.biz-page-title').text.squish },
      yelp_biz_href: allow_nil_for { restaurant_page.at("meta[rel='canonical']")[:href] }
    }

    new(options)
  end

  private

  def self.allow_nil_for(&block)
    begin
      yield
    rescue NoMethodError
      nil
    end
  end
end

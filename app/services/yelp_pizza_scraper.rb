class YelpPizzaScraper
  attr_accessor :query

  YELP_URL = 'https://www.yelp.com'.freeze

  def initialize(query)
    @query = query
  end

  def self.search(query)
    new(query).first_ten_reviews
  end

  def first_ten_reviews
    reviews.map do |review|
      YelpReview.build_from_review_and_page(review, restaurant_page)
    end
  end

  private

  def yelp
    mechanize.get(YELP_URL)
  end

  def results
    yelp.form_with(action: '/search') do |f|
      f['find_desc'] = query + ' pizza'
      f['find_loc'] = 'New York City'
    end.submit
  end

  def restaurant_link
    results.links.select do |link|
      link if link.uri.to_s =~ /\/biz/
    end.first
  end

  def restaurant_page
    @_page ||= restaurant_link.click
  end

  def reviews
    restaurant_page.search(
      'div[data-review-id].review'
    ).first(10)
  end

  def mechanize
    @_mechanize ||= Mechanize.new
  end
end

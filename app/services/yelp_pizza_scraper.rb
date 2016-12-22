class YelpPizzaScraper
  attr_accessor :query

  YELP_URL = 'https://www.yelp.com'.freeze

  def initialize(query)
    @query = query
  end

  def search
    mechanize.get(YELP_URL) do |page|
      results = page.form_with(action: '/search') do |f|
        f['find_desc'] = query + ' pizza'
        f['find_loc'] = 'New York City'
      end.submit

      restaurant_link = results.links.select do |link|
        link if link.uri.to_s =~ /\/biz/
      end.first

      restaurant_page = restaurant_link.click

      reviews = restaurant_page.search('div.review').first(10)
    end
  end

  def mechanize
    @_mechanize ||= Mechanize.new
  end
end

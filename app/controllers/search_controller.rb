class SearchController < ApplicationController
  def index
    @reviews = YelpPizzaScraper.search(query)

    respond_to do |format|
      format.js
    end
  end

  private

  def query
    params[:search][:q]
  end
end

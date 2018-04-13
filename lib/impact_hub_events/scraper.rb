require 'open-uri'
require 'nokogiri'
class ImpactHubEvents::Scraper
  attr_accessor :doc

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_events

  end

end

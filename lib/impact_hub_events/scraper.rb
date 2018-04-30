require 'open-uri'
require 'nokogiri'
require 'pry'
class ImpactHubEvents::Scraper
  attr_accessor :doc

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def create_events
    @doc.css("div.pbr-event-schedule div.row").map do |row|
      ImpactHubEvents::Event.new(row.css("div.col-sm-10 div article div.right a").attribute("href").value)
    end
    #---- From inidividual page

    #date doc.css("div.col-sm-3 ul li span").first.text
    #time doc.css("div.col-sm-3 ul li span")[1].text
    #title doc.css("div.col-sm-9 h1").text
    #location doc.css("div.col-sm-3 ul li span")[3].text
    #description doc.css("div.col-sm-9 p").first.text
  end

  def populate_events
    ImpactHubEvents::Event.all.each do |event|
      event_detail = Nokogiri::HTML(open(event.url))
      event.date = event_detail.css("div.col-sm-3 ul li span").first.text
      event.time = event_detail.css("div.col-sm-3 ul li span")[1].text
      event.title = event_detail.css("div.col-sm-9 h1").text
      event.location = event_detail.css("div.col-sm-3 ul li span")[3].text
      event.description = event_detail.css("div.col-sm-9 p").first.text
    end
  end

end

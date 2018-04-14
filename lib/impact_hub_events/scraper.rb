require 'open-uri'
require 'nokogiri'
class ImpactHubEvents::Scraper
  attr_accessor :doc

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def create_events
    @doc.css("div.pbr-event-schedule div.row div.col-sm-10 article div.right h3 a").map{|link| ImpactHubEvents::Event.new(link.attribute("href").value)}

    #event link @doc.css("div.pbr-event-schedule div.row div.col-sm-10 article div.right h3 a").map{|link| link.attribute("href").value}


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

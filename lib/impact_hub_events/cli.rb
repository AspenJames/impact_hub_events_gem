class ImpactHubEvents::CLI
  def call
    scraper = ImpactHubEvents::Scraper.new("https://impacthubseattle.com/events/")
    scraper.scrape_events
    self.list_menu
  end

  def list_menu

  end
end

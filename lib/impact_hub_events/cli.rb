class ImpactHubEvents::CLI
  def call
    puts "Upcoming events at Impact Hub Seattle:"
    scraper = ImpactHubEvents::Scraper.new("https://impacthubseattle.com/events/")
    scraper.create_events
    scraper.populate_events
    self.list_events
  end

  def list_events
    ImpactHubEvents::Event.all.each_with_index do |event, index|
      puts "#{index + 1}. #{event.title}"
    end

  end

  def list_menu
    puts "Select an event for more info or \"exit!\" to quit."

  end
end

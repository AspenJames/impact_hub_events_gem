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
    puts
    self.list_menu
  end

  def list_detail(event)
    puts
    puts "#{event.title}"
    puts
    puts "Date: #{event.date}"
    puts "Time: #{event.time}"
    puts "Location: #{event.location}"
    unless event.description.nil?
      puts
      puts "#{event.description}"
    end
    puts
    self.list_menu
  end

  def list_menu
    puts "Select an event for more info, \"list\" to view events, or \"exit!\" to quit."
    input = nil
    until input == "exit!"
      input = gets.chomp
      if input.to_i.between?(1, (ImpactHubEvents::Event.all.count + 1))
        self.list_detail(ImpactHubEvents::Event.all[input.to_i - 1])
      elsif input == "list"
        self.list_events
      elsif input == "exit!"
        exit
      else
        puts "I didn't quite get that..."
        self.list_menu
      end
    end
  end



end

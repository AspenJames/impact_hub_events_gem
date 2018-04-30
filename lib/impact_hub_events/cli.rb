require 'paint'
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
      puts Paint["#{index + 1}. #{event.title}", :green]
    end
    puts
    self.list_menu
  end

  def list_detail(event)
    puts
    puts Paint["#{event.title}", :green]
    puts
    puts Paint["Date: #{event.date}", :blue, :bright]
    puts Paint["Time: #{event.time}", :blue, :bright]
    puts Paint["Location: #{event.location}", :blue, :bright]
    unless event.description.nil?
      puts
      puts Paint["#{event.description}", :magenta, :bold]
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

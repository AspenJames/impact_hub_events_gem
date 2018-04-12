class ImpactHubEvents::Event
  attr_accessor :date, :time, :title, :description, :location 

  def initialize
    @@all = []
  end


end

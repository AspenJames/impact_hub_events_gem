class ImpactHubEvents::Event
  attr_accessor :url, :date, :time, :title, :description, :location

  def initialize(url)
    @url = url
    @@all = []
    @@all << self
  end

  def self.all
    @@all
  end


end

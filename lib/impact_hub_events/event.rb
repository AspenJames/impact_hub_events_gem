class ImpactHubEvents::Event
  attr_accessor :url, :date, :time, :title, :description, :location
  @@all = []

  def initialize(url)
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end


end

class WeatherAlertMbj::Alert

  attr_accessor :name, :issue_date, :expiration_date, :urgency, :status, :areas_affected, :state_url, :state, :alert_url

  @@all=[]

  def self.create_alerts(input)

    #def self.create(name)
      #new_artist=self.new(name)
      #new_artist.save
      #new_artist
    #end

    @state = input
    @state_url = "https://alerts.weather.gov/cap/#{@state}.php?x=1"
    #web_scraper
  end

  def web_scraper
    #take the @url and scrape

    doc = Nokogiri::HTML(open(@url))

    doc.css(".entry").each do |box|
      @name = box.css("a").text
      if box.css(".label").text.contains?("Urgency:")
        @urgency = box.css("span").text
      end
    end

    #@@all << self.new

  end




end

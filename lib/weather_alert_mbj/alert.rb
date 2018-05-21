class WeatherAlertMbj::Alert

  attr_accessor :name, :issue_date, :expiration_date, :urgency, :status, :areas_affected, :state_url, :state, :alert_url

  @@all=[]

  def self.all
    @@all
  end

  def self.create_alerts(input)

    alert_1 = self.new
    alert_1.name = "Flood Warning"
    alert_1.state = "ar"
    alert_1.date = "May 21 at 10:47AM CDT"
    alert_1.status = "Actual"
    alert_1.alert_url = "https://alerts.weather.gov/cap/wwacapget.php?x=AR125AA4CB788C.FloodWarning.125AA4D95B3CAR.LZKFLSLZK.7c002c3b990c5673652a38373a4a2842"

    #def self.create(name)
      #new_artist=self.new(name)
      #new_artist.save
      #new_artist
    #end

    #@state = input
    #@state_url = "https://alerts.weather.gov/cap/#{@state}.php?x=1"
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

class WeatherAlertMbj::Alert

  attr_accessor :name, :date, :urgency, :areas_affected, :state_url, :state, :alert_url, :description, :instructions

  #:status

  #@@all=[]

  def self.create_alerts(input)

    alerts_by_state =[]

    url_holder = "https://alerts.weather.gov/cap/#{input}.php?x=1"
    #url_holder = "https://alerts.weather.gov/cap/wwacapget.php?x=CA125AA4CC4028.BeachHazardsStatement.125AA5064C50CA.SGXCFWSGX.166e5bee873489d0175088aad5af3ac9"

    doc = Nokogiri::HTML(open(url_holder))

    #binding.pry

    #doc.css("event").each do |box|
    doc.css("entry").each do |box|
    #doc.css(".headline").each do |box|
      #binding.pry
      new_alert = self.new
      new_alert.state = input.upcase
      #new_alert.state_name = doc.css("title").text.gsub("Current Watches, Warnings and Advisories for ","").gsub(" Issued by the National Weather ServiceThere are no active watches, warnings or advisories","")
      new_alert.state_url = url_holder

      #For states that currently do not have any active watches, warnings or advisories
      if box.css("event").text == ""
        new_alert.name = "There are no active watches, warnings or advisories"
        new_alert.date = "n/a"
        new_alert.urgency = "n/a"
        #new_alert.status = "n/a"
        new_alert.areas_affected = "n/a"
        new_alert.alert_url = "n/a"
        new_alert.description = "n/a"
        new_alert.instructions = "n/a"


      else

        new_alert.name = box.css("event").text #box.text #doc.css("event").first.text #box.css("a").text

        new_alert.alert_url = box.css("link").attribute("href").value

        #webscraping the alert_url for more details
        desc_doc = Nokogiri::HTML(open(new_alert.alert_url))
        new_alert.description = desc_doc.css("description").text
        new_alert.instructions = desc_doc.css("instruction").text

        #binding.pry

        new_alert.urgency = box.css("urgency").text
        #if box.css("urgency").text.downcase == "immediate"
          #new_alert.urgency = box.css("urgency").text.upcase
        #else
          #new_alert.urgency = box.css("urgency").text
        #end

        #Maybe I don't need status? Because it's almost always "actual"
        #new_alert.status = box.css("status").text
        new_alert.areas_affected = box.css("areadesc").text
        new_alert.date = box.css("title").text.partition("issued")[-1].lstrip!.gsub(" by NWS","")

      end

      alerts_by_state << new_alert

      #binding.pry
    end

    #doc.css("link").attribute("href").value



    alerts_by_state

    #binding.pry

  end




    #alert_1 = self.new
    #alert_1.name = "Flood Warning"
    #alert_1.state = "ar"
    #alert_1.issue_date = "May 21 at 10:47AM CDT"
    #alert_1.status = "Actual"
    #alert_1.alert_url = "https://alerts.weather.gov/cap/wwacapget.php?x=AR125AA4CB788C.FloodWarning.125AA4D95B3CAR.LZKFLSLZK.7c002c3b990c5673652a38373a4a2842"

    #@@all << alert_1

    #alert_2 = self.new
    #alert_2.name = "Dense Fog Advisory"
    #alert_2.state = "wi"
    #alert_2.issue_date = "May 21 at 11:01AM CDT"
    #alert_2.status = "Actual"
    #alert_2.alert_url = "https://alerts.weather.gov/cap/wwacapget.php?x=WI125AA4CB8DA4.DenseFogAdvisory.125AA4DA3340WI.MKXNPWMKX.eca3d684369e7e89182de7826d073f28"

    #@@all << alert_2

    #@@all

    #[alert_1,alert_2]

    ###################################
    #still need to figure out how to create multiple instances of the class Alerts

    #def self.create(name)
      #new_artist=self.new(name)
      #new_artist.save
      #new_artist
    #end

    #@state = input
    #@state_url = "https://alerts.weather.gov/cap/#{@state}.php?x=1"
    #web_scraper
  #end

  #def self.web_scraper
    #take the @url and scrape

    #doc = Nokogiri::HTML(open(@state_url))

    #doc.css(".entry").each do |box|
      #@name = box.css("a").text
      #if box.css(".label").text.contains?("Urgency:")
        #@urgency = box.css("span").text
      #end
    #end

    #@@all << self.new

  #end




end

class WeatherAlertMbj::Alert

  attr_accessor :alert_url, :areas_affected, :date, :description, :instructions, :name, :state, :state_url, :status, :urgency

  def self.create_alerts(input)

    url_holder = "https://alerts.weather.gov/cap/#{input}.php?x=1"

    doc = Nokogiri::HTML(open(url_holder))

    doc.css("entry").collect do |box|
      new_alert = self.new
      new_alert.state = input
      new_alert.state_url = url_holder

      #For states that currently do not have any active watches, warnings or advisories
      if box.css("event").text == ""
        new_alert.name = "There are no active watches, warnings or advisories"
        new_alert.date = "n/a"
        new_alert.urgency = "n/a"
        new_alert.status = "n/a"
        new_alert.areas_affected = "n/a"
        new_alert.alert_url = "n/a"
        new_alert.description = "n/a"
        new_alert.instructions = "n/a"

      else
        new_alert.name = box.css("event").text
        new_alert.alert_url = box.css("link").attribute("href").value
        new_alert.urgency = box.css("urgency").text
        new_alert.status = box.css("status").text
        new_alert.areas_affected = box.css("areadesc").text
        new_alert.date = box.css("title").text.partition("issued")[-1].lstrip!.gsub(" by NWS","")

        #webscraping the alert_url for more details
        alert_details = Nokogiri::HTML(open(new_alert.alert_url))
        new_alert.description = alert_details.css("description").text
        new_alert.instructions = alert_details.css("instruction").text
      end

      new_alert
    end
  end

  #def open_in_browser
    #system ("open '#{alert_url}'")
  #end

end

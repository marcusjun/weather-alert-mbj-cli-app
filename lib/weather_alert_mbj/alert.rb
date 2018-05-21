class WeatherAlertMbj::Alert

  attr_accessor :name, :issue_date, :expiration_date, :urgency, :status, :areas_affected, :url, :state

  def self.create_alerts(input)
    @state = input
    @url = "https://alerts.weather.gov/cap/#{@state}.php?x=1"
  end

end

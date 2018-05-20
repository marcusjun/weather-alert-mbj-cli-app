class WeatherAlertMbj::CLI

  def call
    puts "Welcome to Weather Alert."
  end

  def get_state
    puts "Please enter the two-letter code for the state you wish to get weather alerts for."
    puts "For example, CA = California and TX = Texas"
    input = gets.strip
  end

end

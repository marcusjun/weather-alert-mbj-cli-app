class WeatherAlertMbj::CLI

  def call
    puts "Welcome to Weather Alert."
    get_state
    goodbye
  end

  def get_state

    input = ""

    while input != "exit"
      puts "\nPlease enter the two-letter code for the state you wish to get weather alerts for."
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to exit."

      input = gets.strip.downcase

    end
  end

  def goodbye
    puts "Thanks for using Weather alert. Goodbye."
  end

end

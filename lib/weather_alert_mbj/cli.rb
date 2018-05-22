class WeatherAlertMbj::CLI

  attr_accessor :input, :alerts

  STATE_CODES = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo","mt","ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd","oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]

  #Use hash for state codes, instead?
  #STATE_CODES = [{"al" => "alabama"},{"ak" => "alaska"},{"az" => "arizona"}]

  def call
    puts "Welcome to Weather Alert."
    get_states
    goodbye

  end

  def get_states

    #input = ""
    @input = ""

    #while input.downcase != "exit"
    while @input.downcase != "exit"
      puts "\nPlease enter the two-letter code for the state you wish to get weather alerts for."
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to exit."

      #input = gets.strip.downcase
      @input = gets.strip.downcase

      #if STATE_CODES.include?(input)
      if STATE_CODES.include?(@input)

        get_alerts#(input)

        #puts "Valid state code received."
        #@alerts = WeatherAlertMbj::Alert.create_alerts(input)
        #puts @alerts
        #@alerts.each_with_index do |alert,index|
          #puts "  #{index+1} #{alert.name} (#{alert.state.upcase})"
        #end

      elsif input.downcase != "exit"
        puts "Please double check the state code you entered."
      end

    end
  end

  def get_alerts#(input)
    @alerts = WeatherAlertMbj::Alert.create_alerts(@input)

    #puts @alerts

    @alerts.each_with_index do |alert,index|
      #puts "  #{index+1}: #{alert.name} (#{alert.state.upcase})"
      puts "\n  Alert ##{index+1}: #{alert.name} #{alert.urgency} (#{alert.areas_affected})\n"
    end

    menu_input = ""

    while menu_input.downcase != "exit"
      puts "\nPlease enter the number of the weather alert you want more info on."
      puts "Or type 'Exit' to exit."
      menu_input = gets.strip.downcase

      if menu_input.to_i <= @alerts.length
        puts "\nDescription:\n#{@alerts[menu_input.to_i-1].description}"
        puts "\nInstructions:\n#{@alerts[menu_input.to_i-1].instructions}" unless @alerts[menu_input.to_i-1].instructions == ""
        puts "\nFor more info, please see \n  #{@alerts[menu_input.to_i-1].alert_url}"
      elsif menu_input != "exit"
        puts "Please double check the number you entered."
      end
    end
  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye."
    puts "  For more weather alerts, please visit https://alerts.weather.gov/"
  end

end

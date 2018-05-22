class WeatherAlertMbj::CLI

  attr_accessor :input, :alerts

  STATE_CODES = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo","mt","ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd","oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]

  #Use hash for state codes, instead?
  #STATE_CODES = [{"al" => "alabama"},{"ak" => "alaska"},{"az" => "arizona"}]

  def call
    puts "\nWelcome to Weather Alert.".colorize(:color => :blue)#, :background => :light_white)
    get_state_and_its_alerts

    goodbye

  end

  def get_state_and_its_alerts

    #input = ""
    @input = ""

    #while input.downcase != "exit"
    while @input.downcase != "exit"
      puts "\nPlease enter the two-letter code for the state you wish to get weather alerts for.".colorize(:color => :green)
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to exit."

      #input = gets.strip.downcase
      @input = gets.strip.downcase

      line_break

      #if STATE_CODES.include?(input)
      if STATE_CODES.include?(@input)

        @alerts = WeatherAlertMbj::Alert.create_alerts(@input)

        get_and_display_alert_details

        #get_and_list_alerts#(input)

        #puts "Valid state code received."
        #@alerts = WeatherAlertMbj::Alert.create_alerts(input)
        #puts @alerts
        #@alerts.each_with_index do |alert,index|
          #puts "  #{index+1} #{alert.name} (#{alert.state.upcase})"
        #end

      elsif input.downcase != "exit"
        puts "Please double check the state code you entered.".colorize(:color => :light_white, :background => :red)#(:color => :red)
      end

    end
  end

  def display_alerts#(input)
    #@alerts = WeatherAlertMbj::Alert.create_alerts(@input)

    #puts @alerts

    @alerts.each_with_index do |alert,index|
      #puts "  #{index+1}: #{alert.name} (#{alert.state.upcase})"
      puts "\nAlert ##{index+1}: #{alert.name} (#{alert.state.upcase})\n  Urgency: #{alert.urgency}\n  Areas: #{alert.areas_affected}\n  Date: #{alert.date}"
    end

    #get_and_display_alert_details

  end

  def get_and_display_alert_details
    display_alerts

    menu_input = ""

    while menu_input.downcase != "exit"
      #get_and_list_alerts

      line_break
      puts "\nPlease enter the number of the alert for more details.".colorize(:color => :green)
      puts "  Or type 'List' to see a list of alerts."
      puts "  Or type 'Exit' to exit."
      menu_input = gets.strip.downcase

      line_break

      if menu_input.downcase == "list"
        display_alerts

      #if menu_input.to_i <= @alerts.length
      elsif menu_input.to_i <= @alerts.length
        puts "\n#{@alerts[menu_input.to_i-1].name}"
        puts "\nDescription:\n  #{@alerts[menu_input.to_i-1].description}"
        puts "\nInstructions:\n  #{@alerts[menu_input.to_i-1].instructions}" unless @alerts[menu_input.to_i-1].instructions == ""
        puts "\nFor more info, please see \n  #{@alerts[menu_input.to_i-1].alert_url}"

      elsif menu_input != "exit"
        puts "Please double check the number you entered.".colorize(:color => :light_white, :background => :red)
      end
    end


  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye.".colorize(:color => :blue)
    puts "  For more weather alerts, please visit https://alerts.weather.gov/\n".colorize(:color => :blue)
  end

  def line_break
    puts "\n-------------------------------------------------------"
  end

end

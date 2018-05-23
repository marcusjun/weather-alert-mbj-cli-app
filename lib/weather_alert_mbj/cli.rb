class WeatherAlertMbj::CLI

  attr_accessor :input, :alerts

  STATE_CODES = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo","mt","ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd","oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]

  #Use hash for state codes, instead?
  #STATE_CODES = [{"al" => "alabama"},{"ak" => "alaska"},{"az" => "arizona"}]

  def call
    puts "\nWelcome to Weather Alert.".colorize(:color => :blue)#.colorize(:color => :light_white)#, :background => :light_white)
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

      #line_break

      #if STATE_CODES.include?(input)
      if STATE_CODES.include?(@input)

        puts "\nLoading data for " + "#{@input.upcase}".colorize(:color => :blue) + " ..."
        puts "(It may take up to 1 minute to retrieve data.)"

        line_break

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
        line_break
        puts "\nPlease double check the state code you entered.".colorize(:color => :light_white, :background => :red)#(:color => :red)
        line_break
      end

    end
  end

  def display_alerts#(input)
    #@alerts = WeatherAlertMbj::Alert.create_alerts(@input)

    #puts @alerts

    @alerts.each_with_index do |alert,index|

      if alert.name == "There are no active watches, warnings or advisories"
        puts "\n#{alert.name} for #{alert.state.upcase}.".colorize(:color => :blue)

      else
        #puts "  #{index+1}: #{alert.name} (#{alert.state.upcase})"
        puts "\nAlert ##{index+1}: #{alert.name} (#{alert.state.upcase})".colorize(:color => :blue)
        if alert.urgency.downcase == "immediate"
          puts "  Urgency: #{alert.urgency}".colorize(:color => :red)#, :background => :light_white)
        else
          puts "  Urgency: #{alert.urgency}"
        end
        puts "  Areas: #{alert.areas_affected}\n  Date: #{alert.date}"
      end
    end

    #get_and_display_alert_details

  end

  def get_and_display_alert_details
    display_alerts

    menu_input = ""

    while menu_input.downcase != "exit"
      #get_and_list_alerts

      if @alerts[0].name == "There are no active watches, warnings or advisories"
        line_break
        puts "\nType 'Exit' to return to the previous menu.".colorize(:color => :green)
        menu_input = gets.strip.downcase
        line_break
      else
        line_break
        puts "\nPlease enter a number (from 1 - #{@alerts.length}) of the alert for more details.".colorize(:color => :green)
        puts "  Or type 'List' to see a list of alerts."
        puts "  Or type 'Exit' to exit."
        menu_input = gets.strip.downcase

        line_break


        if menu_input.downcase == "list"
          display_alerts

        #if menu_input.to_i <= @alerts.length
        elsif menu_input.to_i <= @alerts.length && menu_input.to_i > 0
          puts "\nAlert ##{menu_input}: #{@alerts[menu_input.to_i-1].name} (#{@alerts[menu_input.to_i-1].state.upcase})".colorize(:color => :blue)
          puts "\nDescription:".colorize(:color => :blue)
          puts "#{@alerts[menu_input.to_i-1].description}"
          puts "\nInstructions:".colorize(:color => :blue) unless @alerts[menu_input.to_i-1].instructions == ""
          puts "#{@alerts[menu_input.to_i-1].instructions}" unless @alerts[menu_input.to_i-1].instructions == ""
          puts "\nFor more info, please see".colorize(:color => :blue)
          puts"#{@alerts[menu_input.to_i-1].alert_url}"

        elsif menu_input != "exit"
          puts "\nPlease double check the number you entered.".colorize(:color => :light_white, :background => :red)
        end
      end
    end


  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye.".colorize(:color => :blue)#.colorize(:color => :light_white)
    puts "  For more weather alerts, please visit https://alerts.weather.gov/\n".colorize(:color => :blue)#.colorize(:color => :light_white)
  end

  def line_break
    puts "\n---------------------------------------------------------------------------"
  end

end

class WeatherAlertMbj::CLI

  #attr_accessor :alerts #:input

  #STATE_CODES = ["al", "ak", "as", "az", "ar", "ca", "co", "ct", "dc", "de", "fl", "ga", "gu", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "mp", "ms", "mo", "mt", "ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "pr", "ri", "sc", "sd", "tn", "tx", "um", "us", "ut", "vt", "va", "vi", "wa", "wv", "wi", "wy"]

  STATE_CODES={
    "al" => "Alabama",
    "ak" => "Alaska",
    "az" => "Arizona",
    "ar" => "Arkansas",
    "ca" => "California",
    "co" => "Colorado",
    "ct" => "Connecticut",
    "de" => "Delware",
    "dc" => "District of Columbia",
    "fl" => "Florida",
    "ga" => "Georgia",
    "hi" => "Hawaii",
    "id" => "Idaho",
    "il" => "Illinois",
    "in" => "Indiana",
    "ia" => "Iowa",
    "ks" => "Kansas",
    "ky" => "Kentucky",
    "la" => "Louisiana",
    "me" => "Maine",
    "md" => "Maryland",
    "ma" => "Massachusetts",
    "mi" => "Michigan",
    "mn" => "Minnesota",
    "ms" => "Mississippi",
    "mo" => "Missouri",
    "mt" => "Montana",
    "ne" => "Nebraska",
    "nv" => "Nevada",
    "nh" => "New Hampshire",
    "nj" => "New Jersey",
    "nm" => "New Mexico",
    "ny" => "New York",
    "nc" => "North Carolina",
    "nd" => "North Dakota",
    "oh" => "Ohio",
    "ok" => "Oklahoma",
    "or" => "Oregon",
    "pa" => "Pennsylvania",
    "ri" => "Rhode Island",
    "sc" => "South Carolina",
    "sd" => "South Dakota",
    "tn" => "Tennessee",
    "tx" => "Texas",
    "us" => "United States",
    "ut" => "Utah",
    "vt" => "Vermont",
    "va" => "Virginia",
    "wa" => "Washington",
    "wv" => "West Virginia",
    "wi" => "Wisconsin",
    "wy" => "Wyoming",
    #US territories and other
    "as" => "American Samoa",
    "gu" => "Guam",
    "mp" => "Northern Mariana Islands",
    "pr" => "Puerto Rico",
    "vi" => "U.S. Virgin Islands",
    "um" => "U.S. Minor Outlying Islands"
  }


  def call
    line_break
    puts "\nWelcome to Weather Alert.".colorize(:color => :blue)#.colorize(:color => :light_white)#, :background => :light_white)

    get_state_and_its_alerts

    goodbye

  end

  def get_state_and_its_alerts

    #input = ""
    input = ""

    #while input.downcase != "exit"
    while input.downcase != "exit"
      puts "\nPlease enter the two-letter code for the US state or territory\nyou wish to get weather alerts for.".colorize(:color => :green)
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to quit Weather Alert."

      #input = gets.strip.downcase
      input = gets.strip.downcase

      #binding.pry

      #line_break

      #if STATE_CODES.include?(input)
      #if STATE_CODES.include?(@input)
      if STATE_CODES.keys.include?(input) || STATE_CODES.any? {|key,value| value.downcase == input}

        ##if STATE_CODES.values.include?(@input)
        if STATE_CODES.any? {|key,value| value.downcase == input}
          STATE_CODES.each do |key,value|
            if value.downcase == input
              input = STATE_CODES.key(value)
            end
          end
        end
          #binding.pry
        ##end

        #puts "\nLoading data for " + "#{@input.upcase}".colorize(:color => :blue) + " ..."
        puts "\nLoading data for " + "#{STATE_CODES[input]}".colorize(:color => :blue) + " ..."
        puts "(It may take up to 1 minute to retrieve data.)"

        line_break

        @alerts = WeatherAlertMbj::Alert.create_alerts(input)

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
        puts "\nPlease double check the code you entered.".colorize(:color => :light_white, :background => :red)#(:color => :red)
        line_break
      end

    end
  end

  def display_alerts#(input)
    #@alerts = WeatherAlertMbj::Alert.create_alerts(@input)

    #puts @alerts

    @alerts.each_with_index do |alert,index|

      if alert.name == "There are no active watches, warnings or advisories"
        #puts "\nAs of #{Time.now.asctime}: #{alert.name} for #{alert.state.upcase}.".colorize(:color => :blue)
        #puts "\n  Currently, #{alert.name.downcase} for #{alert.state.upcase}.".colorize(:color => :blue)
        puts "\n  Currently, #{alert.name.downcase} for #{STATE_CODES[alert.state]}.".colorize(:color => :blue)
        #line_break

        #get_state_and_its_alerts

      else
        #puts "  #{index+1}: #{alert.name} (#{alert.state.upcase})"
        #puts "\nAlert ##{index+1}: #{alert.name} (#{alert.state.upcase})".colorize(:color => :blue)
        #binding.pry
        puts "\nAlert ##{index+1}: #{alert.name} (#{STATE_CODES[alert.state]})".colorize(:color => :blue)
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
        #line_break
        #puts "\nType 'Exit' to return to the previous menu.".colorize(:color => :green)
        menu_input = "exit"#gets.strip.downcase
        line_break
      else
        line_break
        puts "\nPlease enter a number (from 1 - #{@alerts.length}) of the alert for more details.".colorize(:color => :green)
        puts "  Or type 'List' to see a list of alerts."
        puts "  Or type 'Exit' to return to the previous menu."
        menu_input = gets.strip.downcase

        line_break


        if menu_input.downcase == "list"
          display_alerts

        #if menu_input.to_i <= @alerts.length
        elsif menu_input.to_i <= @alerts.length && menu_input.to_i > 0
          #puts "\nAlert ##{menu_input}: #{@alerts[menu_input.to_i-1].name} (#{@alerts[menu_input.to_i-1].state.upcase})".colorize(:color => :blue)
          #binding.pry
          puts "\nAlert ##{menu_input}: #{@alerts[menu_input.to_i-1].name} (#{STATE_CODES[@alerts[menu_input.to_i-1].state]})".colorize(:color => :blue)
          puts "\nDescription:".colorize(:color => :blue)
          puts "#{@alerts[menu_input.to_i-1].description}"
          puts "\nInstructions:".colorize(:color => :blue) unless @alerts[menu_input.to_i-1].instructions == ""
          puts "#{@alerts[menu_input.to_i-1].instructions}" unless @alerts[menu_input.to_i-1].instructions == ""
          puts "\nFor more info, please see".colorize(:color => :blue)
          puts"#{@alerts[menu_input.to_i-1].state_url}"
          puts"#{@alerts[menu_input.to_i-1].alert_url}"

        elsif menu_input != "exit"
          puts "\n  Please double check the number you entered.".colorize(:color => :light_white, :background => :red)
        end
      end
    end


  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye.".colorize(:color => :blue)#.colorize(:color => :light_white)
    puts "  For more weather alerts, please visit https://alerts.weather.gov/\n".colorize(:color => :blue)#.colorize(:color => :light_white)
  end

  def line_break
    puts "\n---------------------------------------------------------------------------".colorize(:color => :light_white)
    #puts "\n...........................................................................".colorize(:color => :light_white)
  end

end

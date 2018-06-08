class WeatherAlertMbj::CLI

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
    puts "\nWelcome to Weather Alert.".colorize(:color => :blue)

    get_state_and_its_alerts
    goodbye
  end

  def get_state_and_its_alerts

    state_input = ""

    while state_input.downcase != "exit"
      puts "\nPlease enter the two-letter code for the US state or territory\nyou wish to get weather alerts for.".colorize(:color => :green)
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to quit Weather Alert."

      state_input = gets.strip.downcase

      #Conditional statement that ensures user input is a valid state code or valid state name
      if STATE_CODES.keys.include?(state_input) || STATE_CODES.any? {|state_code,state_name| state_name.downcase == state_input}

        #If user inputs full name of state (California) rather than its code (CA)
        #then the following code assigns state_input to the state code.
        STATE_CODES.each {|state_code,state_name| state_input = STATE_CODES.key(state_name) if state_input == state_name.downcase}

        puts "\nLoading data for " + "#{STATE_CODES[state_input]}".colorize(:color => :blue) + "..."
        puts "(It may take up to 1 minute to retrieve data.)"
        line_break

        @state_alerts = WeatherAlertMbj::Alert.create_alerts(state_input)

        get_and_display_alert_details

      elsif state_input.downcase != "exit"
        line_break
        puts "\n  Please double check the code you entered.  ".colorize(:color => :light_white, :background => :red)#(:color => :red)
        line_break
      end

    end
  end

  def get_and_display_alert_details
    display_alerts

    menu_input = ""

    while menu_input.downcase != "exit"

      if @state_alerts[0].name == "There are no active watches, warnings or advisories"

        #If a state has no weather alerts, then menu_input is set to "exit"
        #because there are no alerts to get more details on.
        menu_input = "exit"
        line_break
      else
        line_break
        puts "\nPlease enter the number (from 1 - #{@state_alerts.length}) of the alert for more details.".colorize(:color => :green)
        puts "  Or type 'List' to see a list of alerts."
        puts "  Or type 'Exit' to return to the previous menu."
        line_break

        menu_input = gets.strip.downcase

        if menu_input.downcase == "list"
          display_alerts

        #elsif menu_input.to_i <= @state_alerts.length && menu_input.to_i > 0
        elsif menu_input.to_i.between?(1,@state_alerts.length)

          selected_alert = @state_alerts[menu_input.to_i-1]

          #Displays the details of an alert including its
          #name, state, urgency (if immediate), description, instructions and urls.

          puts "\nAlert ##{menu_input}: #{selected_alert.name} (#{STATE_CODES[selected_alert.state]})".colorize(:color => :blue)

          puts "Urgency: #{selected_alert.urgency}".colorize(:color => :red) if selected_alert.urgency.downcase == "immediate"

          puts "\nDescription:".colorize(:color => :blue)
          puts "#{selected_alert.description}"

          puts "\nInstructions:".colorize(:color => :blue) unless selected_alert.instructions == ""
          puts "#{selected_alert.instructions}" unless selected_alert.instructions == ""

          puts "\nFor more info, please see".colorize(:color => :blue)
          puts "#{selected_alert.state_url}"
          puts "#{selected_alert.alert_url}"

        elsif menu_input != "exit"
          puts "\n  Please double check the number you entered.  ".colorize(:color => :light_white, :background => :red)
        end
      end
    end
  end


  def display_alerts

    @state_alerts.each_with_index do |alert,index|

      selected_state = STATE_CODES[alert.state]

      if alert.name == "There are no active watches, warnings or advisories"
        puts "\n  Currently, #{alert.name.downcase} for #{selected_state}.".colorize(:color => :blue)

      else
        puts "\nAlert ##{index+1}: #{alert.name} (#{selected_state})".colorize(:color => :blue)

        #Alerts with an "immediate" urgency have the text, "immediate" in red.
        if alert.urgency.downcase == "immediate"
          puts "  Urgency: #{alert.urgency}".colorize(:color => :red)
        else
          puts "  Urgency: #{alert.urgency}"
        end

        puts "  Areas: #{alert.areas_affected}"
        puts "  Date: #{alert.date}"
      end
    end
  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye.".colorize(:color => :blue)
    puts "  For more weather alerts, please visit https://alerts.weather.gov/\n".colorize(:color => :blue)
  end

  def line_break
    puts "\n-------------------------------------------------------------------------------------".colorize(:color => :light_white)
  end
end

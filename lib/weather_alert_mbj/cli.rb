class WeatherAlertMbj::CLI

  STATE_CODES = ["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]

  def call
    puts "Welcome to Weather Alert."
    get_state
    goodbye
  end

  def get_state

    input = ""

    while input.upcase != "EXIT"
      puts "\nPlease enter the two-letter code for the state you wish to get weather alerts for."
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to exit."

      input = gets.strip.upcase

      #if !STATE_CODES.include? (input) && input.upcase != "EXIT"
      if STATE_CODES.include?(input)
        puts "Valid state code received."
        #puts "\n  Please double check the state code you entered."
        #get_state
      elsif input.upcase != "EXIT"
        puts "Please double check the state code you entered."
      end

    end
  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye."
  end

end

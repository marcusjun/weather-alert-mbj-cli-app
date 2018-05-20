class WeatherAlertMbj::CLI

  STATE_CODES = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo","mt","ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd","oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]

  def call
    puts "Welcome to Weather Alert."
    get_state
    goodbye
  end

  def get_state

    input = ""

    while input.downcase != "exit"
      puts "\nPlease enter the two-letter code for the state you wish to get weather alerts for."
      puts "  For example, CA = California and TX = Texas"
      puts "  Or type 'Exit' to exit."

      input = gets.strip.downcase

      if STATE_CODES.include?(input)
        puts "Valid state code received."
      elsif input.downcase != "exit"
        puts "Please double check the state code you entered."
      end

    end
  end

  def goodbye
    puts "\nThanks for using Weather Alert. Goodbye."
  end

end

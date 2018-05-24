
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "weather_alert_mbj/version"

Gem::Specification.new do |spec|
  spec.name          = "weather_alert_mbj"
  spec.version       = WeatherAlertMbj::VERSION
  spec.authors       = ["'Marcus Jun'"]
  spec.email         = ["'mjun@calstate.edu'"]

  spec.summary       = "This gem uses webscraping to get National Weather Service weather alerts by state. See https://alerts.weather.gov/"
    #%q{TODO: Write a short summary, because RubyGems requires one.}
  spec.description   = "The user enters a US state or territory and the gem returns a list of weather alerts. Then user can choose a weather alert to see more details."
    #%q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/marcusjun/weather-alert-mbj-cli-app"
    #"TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  # My modifications below
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"

end

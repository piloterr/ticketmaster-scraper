# Ticketmaster Event API – Ruby example (stdlib only)
# Usage: PILOTERR_API_KEY=your-key ruby event.rb
require "json"
require "net/http"
require "uri"

uri = URI("https://api.piloterr.com/v2/ticketmaster/event")
uri.query = URI.encode_www_form('query' => 'https://www.ticketmaster.com/suns-vs-jazz-kids-day-phoenix-arizona-01-24-2027/event/19006507A7257EEA')

request = Net::HTTP::Get.new(uri)
request["x-api-key"] = ENV.fetch("PILOTERR_API_KEY")

response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 120) do |http|
  http.request(request)
end

abort "Piloterr error #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

puts JSON.pretty_generate(JSON.parse(response.body))

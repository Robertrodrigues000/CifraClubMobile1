require 'net/http'
require 'json'
require 'uri'
require 'open3'

command = "git diff origin/development | " +
  "pull_request_coverage " +
  "--output-mode markdown " +
  "--fully-tested-message '![](https://media.giphy.com/media/NL29ljExEdxEj9m6kC/giphy.gif)' " +
  "--report-fully-covered-files false"

stdout, stderr, status = Open3.capture3(command)

message = stdout + "\n" + "[Details](#{ENV['DRONE_BUILD_LINK'].to_s + '/1/7'})"

uri = URI('https://us-central1-integral-accord-651.cloudfunctions.net/coverage')
Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request.body = {
    organization: ENV['DRONE_REPO_NAMESPACE'],
    repository: ENV['DRONE_REPO_NAME'],
    pull_request_number: ENV['DRONE_PULL_REQUEST'],
    message: message
  }.to_json
  response = http.request request
  puts "Response from Google Cloud Function: #{response.body}"
end

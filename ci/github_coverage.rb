require 'net/http'
require 'json'
require 'uri'
require 'open3'

command = "git diff origin/development_flutter | " +
  "flutter pub run pull_request_coverage " +
  "--minimum-coverage 97 " +
  "--maximum-uncovered-lines 5 " +
  "--output-mode markdown " +
  "--use-colorful-output true " +
  "--report-fully-covered-files false"

stdout, stderr, status = Open3.capture3(command)

message = stdout + "\n" +
  "[Details](#{ENV['DRONE_BUILD_LINK'] + '/1/7'})"

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
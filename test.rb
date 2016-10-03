require 'json'

data = File.read('report_site/data/accessibility_validation_sample.json')
json_data = JSON.parse(data)


json_data["ws_eval_rule_results"].each do |result|
  puts result if result['fields']['pages_violation'] > 0
end


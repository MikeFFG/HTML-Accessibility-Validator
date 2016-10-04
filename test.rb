require 'json'

data = File.read('report_site/data/accessibility_validation_sample.json')
json_data = JSON.parse(data)

filtered = json_data["page_eval_rule_results"].select do |result|
  result['fields']['elements_violation'] > 0
end

filtered.each do |result|
  puts result['fields']['rule'][0]
  puts result['fields']['rule'][1]
  puts result['fields']['rule'][3]
  puts result['fields']['message']
  puts 'number of violations: ' + result['fields']['elements_violation'].to_s
  puts
  puts
end

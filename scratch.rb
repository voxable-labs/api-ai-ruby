require 'api-ai-ruby'
require 'json'
require '/Users/techpeace/.rvm/gems/ruby-2.2.0@vthreat/gems/awesome_print-1.6.1/lib/awesome_print'

client = ApiAiRuby::Client.new(
  client_access_token: '6075a4572e17430d8976d3d236962ac4',
  developer_access_token: '9da728dd53cd47ba8de7b87080ccaa4b',
  subscription_key: '24c81cc6-0d3d-4a1c-8701-a3bd7ba6b02a',
)

=begin
result = client.text_request('hello there')
puts result.inspect

entities = [
  {
    name: 'car',
    entries: [
      {
        value: 'car',
        synonyms: %w(car auto bus trike)
      }
    ]
  }
]
result = client.update_entities_request(entities)

puts result.inspect

#curl -k -X PUT --data "[{'name': 'car', 'entries': [{'value':'car', 'synonyms':['car', 'auto', 'bus', 'whip']} ]}]" -H "Content-Type: application/json" -H "Authorization: Bearer 5dae99c607d2462bb11e1c2882816125" -H "ocp-apim-subscription-key: 24c81cc6-0d3d-4a1c-8701-a3bd7ba6b02a" "https://api.api.ai/api/entities?v=20150204"

intent = {
    "id": "1dbfe740-2fbd-4c5e-95cf-0b3090eda942",
    "name": "launchSimulation",
    "auto": true,
    "contexts": [],
    "templates": [
        "launch a @simulation:simulationName @sys.date-time:simulationTime",
        "open @simulation:simulationName @sys.date-time:simulationTime",
        "run a @simulation:simulationName @sys.date-time:simulationTime",
        "run a @simulation:simulationName simulation @sys.date-time:simulationTime"
    ],
    "responses": [
        {
            "resetContexts": false,
            "affectedContexts": [],
            "parameters": [
                {
                    "required": true,
                    "dataType": "@simulation",
                    "name": "simulationName",
                    "value": "$simulationName",
                    "prompts": [
                        "Okay, which simulation would you like to run?",
                        nil
                    ]
                },
                {
                    "required": false,
                    "dataType": "@sys.date-time",
                    "name": "simulationTime",
                    "value": "$simulationTime",
                    "defaultValue": ""
                }
            ],
            "speech": "okay, launching $simulationName simulation"
        }
    ],
    "state": "LEARNED",
    "priority": 750000,
    "cortanaCommand": {
        "navigateOrService": "NAVIGATE",
        "target": ""
    },
    "assistantCommand": {
        "urlCommand": "",
        "doCommand": ""
    }
}

result = client.update_intent_request(intent)

puts result
=end

#result = client.get_intent_request('1dbfe740-2fbd-4c5e-95cf-0b3090eda942')
result = client.get_intents_request
puts result.to_json


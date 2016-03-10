require 'json'

module ApiAiRuby
  class UpdateIntentRequest < ApiAiRuby::Request
    def initialize (client, options={})
      @path = "intents/#{ options[:json][:id] }"

      super client, options
      @request_method = :put
      # TODO: There should be a method for generating the proper headers.
      @headers = {
          'Authorization': 'Bearer ' + client.developer_access_token,
          'ocp-apim-subscription-key': client.subscription_key
      }
    end
  end
end

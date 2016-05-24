require 'json'

module ApiAiRuby
  class GetIntentRequest < ApiAiRuby::Request
    def initialize (client, options={})
      @path = "intents/#{ options.delete(:iid) }"

      super client, options
      @request_method = :get

      # TODO: There should be a method for generating the proper headers.
      @headers = {
          'Authorization': 'Bearer ' + client.developer_access_token
      }
    end
  end
end

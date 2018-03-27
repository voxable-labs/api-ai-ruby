require 'json'

module VoxableApiAiRuby
  class UpdateIntentRequest < VoxableApiAiRuby::Request
    def initialize (client, options={})
      @path = "intents/#{ options[:json][:id] }"

      super client, options
      @request_method = :put
      # TODO: There should be a method for generating the proper headers.
      @headers = {
          'Authorization': 'Bearer ' + client.developer_access_token,
          'Content-Type': 'application/json; charset=utf-8'
      }
    end
  end
end

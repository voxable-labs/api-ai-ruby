module ApiAiRuby
  class GetEntityRequest < ApiAiRuby::Request
    def initialize (client, options={})
      @path = "entities/#{ options.delete(:eid) }"

      super client, options
      @request_method = :get

      # TODO: There should be a method for generating the proper headers.
      @headers = {
        'Authorization': 'Bearer ' + client.developer_access_token
      }
    end
  end
end

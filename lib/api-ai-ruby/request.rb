require 'http'
require 'http/form_data'
require 'uri'

module ApiAiRuby
  class Request

    attr_accessor :client, :headers, :options,  :request_method, :uri

    # @param client [ApiAiRuby::Client]
    # @param path [String] the path to the proper API endpoint
    # @param options [Hash]
    # @return [ApiAiRuby::TextRequest]

    def initialize(client, options = {})
      @client = client
      @uri = client.api_base_url + @path + '?v=' + client.api_version
      @request_method = :post
      options[:params] ||= {}
      options[:params] = options[:params].merge({ lang: client.api_lang })
      @options = options
      @headers = {
          'Authorization': 'Bearer ' + client.client_access_token,
          'Content-Type': 'application/json; charset=UTF-8'
      }
    end

    # @return [Array, Hash]
    def perform
      response = HTTP.with(@headers).public_send(@request_method, @uri.to_s, @options)

      response_body = symbolize_keys!(response.parse)
      response_headers = response.headers
      fail_or_return_response_body(response.code, response_body)
    end

    private


    def fail_or_return_response_body(code, body)
      error = false
      if code != 200 || ( !body.kind_of?(Array) && body[:status] && body[:status][:code] != 200 )
        error = ApiAiRuby::RequestError.new body[:status][:errorDetails], body[:status][:code]
      end
      fail(error) if error
      body
    end

    def symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = symbolize_keys!(val)
        end
      elsif object.is_a?(Hash)
        object.keys.each do |key|
          object[key.to_sym] = symbolize_keys!(object.delete(key))
        end
      end
      object
    end
  end
end
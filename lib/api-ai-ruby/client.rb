module ApiAiRuby
  class Client
    attr_accessor :client_access_token, :developer_access_token, :subscription_key
    attr_writer :user_agent, :api_version, :api_lang, :api_base_url

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Twitter::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "ApiAiRubyGem/#{ApiAiRuby::Constants::VERSION}"
    end

    def api_base_url
      @api_base_url ||= ApiAiRuby::Constants::DEFAULT_BASE_URL
    end

    def api_lang
      @api_lang ||= ApiAiRuby::Constants::DEFAULT_CLIENT_LANG
    end

    def api_version
      @api_version ||= ApiAiRuby::Constants::DEFAULT_API_VERSION
    end

    # @return [Hash]
    def credentials
      {
          client_access_token: client_access_token,
          developer_access_token: developer_access_token,
          subscription_key: subscription_key
      }
    end

    # @return [Boolean] true if the client credentials are present
    def client_credentials?
      credentials[:client_access_token] && credentials[:subscription_key]
    end

    # @return [Boolean] true if the developer credentials are present
    def developer_credentials?
      credentials[:developer_access_token] && credentials[:subscription_key]
    end

    def text_request (query = '', options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !client_credentials?
      options[:params] ||= {}
      options[:params] = options[:params].merge({ query: query })
      ApiAiRuby::TextRequest.new(self, options).perform
    end

    def voice_request(file_stream, options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !client_credentials?
      options[:form] ||= {}
      options[:form] = options[:form].merge({ file: file_stream })
      ApiAiRuby::VoiceRequest.new(self, options).perform
    end

    def update_entities_request(entities, options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:json] = entities
      ApiAiRuby::UpdateEntitiesRequest.new(self, options).perform
    end

    def update_intent_request(intent, options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:json] = intent
      ApiAiRuby::UpdateIntentRequest.new(self, options).perform
    end

    def get_intent_request(iid, options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:iid] = iid
      ApiAiRuby::GetIntentRequest.new(self, options).perform
    end
  end
end
module VoxableApiAiRuby
  class Client
    attr_accessor :client_access_token, :developer_access_token
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
      @user_agent ||= "ApiAiRubyGem/#{VoxableApiAiRuby::Constants::VERSION}"
    end

    def api_base_url
      @api_base_url ||= VoxableApiAiRuby::Constants::DEFAULT_BASE_URL
    end

    def api_lang
      @api_lang ||= VoxableApiAiRuby::Constants::DEFAULT_CLIENT_LANG
    end

    def api_version
      @api_version ||= VoxableApiAiRuby::Constants::DEFAULT_API_VERSION
    end

    # @return [Hash]
    def credentials
      {
          client_access_token: client_access_token,
          developer_access_token: developer_access_token
      }
    end

    # @return [Boolean] true if the client credentials are present
    def client_credentials?
      credentials[:client_access_token]
    end

    # @return [Boolean] true if the developer credentials are present
    def developer_credentials?
      credentials[:developer_access_token]
    end

    def text_request (query = '', options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !client_credentials?
      options[:params] ||= {}
      options[:params] = options[:params].merge({ query: query })
      VoxableApiAiRuby::TextRequest.new(self, options).perform
    end

    def voice_request(file_stream, options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !client_credentials?
      options[:form] ||= {}
      options[:form] = options[:form].merge({ file: file_stream })
      VoxableApiAiRuby::VoiceRequest.new(self, options).perform
    end

    def update_entities_request(entities, options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:json] = entities
      VoxableApiAiRuby::UpdateEntitiesRequest.new(self, options).perform
    end

    def update_intent_request(intent, options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:json] = intent
      VoxableApiAiRuby::UpdateIntentRequest.new(self, options).perform
    end

    def get_intent_request(iid, options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:iid] = iid
      VoxableApiAiRuby::GetIntentRequest.new(self, options).perform
    end

    def get_intents_request(options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      VoxableApiAiRuby::GetIntentRequest.new(self, options).perform
    end

    def get_entity_request(eid, options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      options[:eid] = eid
      VoxableApiAiRuby::GetEntityRequest.new(self, options).perform
    end

    def get_entities_request(options = {})
      raise VoxableApiAiRuby::ClientError.new('Credentials missing') if !developer_credentials?
      VoxableApiAiRuby::GetEntityRequest.new(self, options).perform
    end
  end
end

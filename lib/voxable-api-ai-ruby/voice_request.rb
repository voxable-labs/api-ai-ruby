require 'json'

module VoxableApiAiRuby
  class VoiceRequest < VoxableApiAiRuby::Request
    # @param client [VoxableApiAiRuby::Client]
    # @param options [Hash]
    # @return [VoxableApiAiRuby::VoiceRequest]
    def initialize(client,  options = {})
      @path = 'query'

      super client, options

      file = options.delete(:file)
      options = {
          :request => options.to_json,
          :voiceData => HTTP::FormData::File.new(file, filename: File.basename(file))
      }
      @options = options

      self
    end
  end
end

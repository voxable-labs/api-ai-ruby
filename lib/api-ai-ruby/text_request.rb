module ApiAiRuby
  class TextRequest < ApiAiRuby::Request
    def initialize (client, options={})
      @path = 'query'

      super client, options
      @request_method = :get
    end
  end
end

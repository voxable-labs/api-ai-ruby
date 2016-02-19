module ApiAiRuby
  class TextRequest < ApiAiRuby::RequestQuery
    def initialize (client, options={})
      @path = 'query'

      super client, options
      @request_method = :get
    end
  end
end

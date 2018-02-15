module VoxableApiAiRuby
  class RequestError < StandardError
    #return [Integer]
    attr_reader :code

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param code [Integer]
    # @return [VoxableApiAiRuby::RequestError]
    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end

  end
end

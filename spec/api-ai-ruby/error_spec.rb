require 'helper'

describe VoxableApiAiRuby::RequestError do
  describe '#code' do
    it 'returns the error code' do
      error = VoxableApiAiRuby::RequestError.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = VoxableApiAiRuby::RequestError.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end
end

describe VoxableApiAiRuby::ClientError do

end

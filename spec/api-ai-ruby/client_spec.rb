require 'helper'

describe ApiAiRuby::Client do
  describe '#user_agent' do
    it 'defaults ApiAiRubyRubyGem/version' do
      expect(subject.user_agent).to eq("ApiAiRubyGem/#{ApiAiRuby::Constants::VERSION}")
    end
  end

  describe '#user_agent=' do
    it 'overwrites the User-Agent string' do
      subject.user_agent = 'MyApiAiRubyClient/1.0.0'
      expect(subject.user_agent).to eq('MyApiAiRubyClient/1.0.0')
    end
  end

  describe '#client_credentials?' do
    it 'returns true if all client credentials are present' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS')
      expect(client.client_credentials?).to be_truthy
    end

    it 'returns false if any client credentials are missing' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK')
      expect(client.client_credentials?).to be_falsey
    end

    it 'raises error on request without client credentials' do
      expect {subject.text_request '123'}.to raise_error(ApiAiRuby::ClientError)
      expect {subject.voice_request '123'}.to raise_error(ApiAiRuby::ClientError)
    end
  end

  describe '#developer_credentials?' do
    it 'returns true if all developer credentials are present' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', developer_access_token: 'CS')
      expect(client.developer_credentials?).to be_truthy
    end

    it 'returns false if any developer credentials are missing' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK')
      expect(client.developer_credentials?).to be_falsey
    end

    it 'raises error on request without developer credentials' do
      expect {subject.text_request '123'}.to raise_error(ApiAiRuby::ClientError)
      expect {subject.voice_request '123'}.to raise_error(ApiAiRuby::ClientError)
    end
  end

  describe '#properties' do

    it 'has correct default properties' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS')
      expect(client.api_base_url).to eq ApiAiRuby::Constants::DEFAULT_BASE_URL
      expect(client.api_version).to eq ApiAiRuby::Constants::DEFAULT_API_VERSION
      expect(client.api_lang).to eq ApiAiRuby::Constants::DEFAULT_CLIENT_LANG
    end

    it 'correctly creates client with given properties' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS', api_lang: 'RU', api_base_url: 'http://localhost', api_version: '1234')
      expect(client.api_base_url).to eq 'http://localhost'
      expect(client.api_version).to eq '1234'
      expect(client.api_lang).to eq 'RU'
    end


  end

end

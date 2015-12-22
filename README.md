# The API.AI ruby gem

A Ruby SDK to the https://api.ai natural language processing service.

## Installation
    gem install api-ai-ruby

## Basic Usage

Just pass correct credentials to ApiAiRuby::Client constructor

```ruby
client = ApiAiRuby::Client.new(
    :client_access_token => 'YOUR_ACCESS_TOKEN',
    :subscription_key => 'YOUR_SUBSCRIPTION_KEY'
)
```
After that you can send text requests to the https://api.ai with command

```ruby
response = client.text_request 'hello!'
```

And voice requests with file stream

```ruby
file = File.new 'hello.wav'
response = client.voice_request(file)
```

Example answer:
```
{
  :id        => "6daf5ab7-276c-43ad-a32d-bf6831918492",
  :timestamp => "2015-12-22T08:42:15.785Z",
  :result    => {
    :source        => "agent",
    :resolvedQuery => "Hello",
    :speech        => "Hi! How are you?",
    :action        => "greeting",
    :parameters    => {},
    :contexts      => [],
    :metadata      => {
      :intentId   => "a5d685ab-1f19-46b0-9478-69f794553668",
      :intentName => "hello"
    }
  },
  :status    => {
    :code      => 200,
    :errorType => "success"
  }
}
```

voice_request and text_request methods returns symbolized https://api.ai response. Structure of response can be found here (https://docs.api.ai/docs/query#response)

## Advanced usage

During client instantination you can additionally set parameters like api url, request language and version (more info at https://docs.api.ai/docs/versioning, https://docs.api.ai/docs/languages)

```ruby
ApiAiRuby::Client.new(
    subscription_key: 'YOUR_SUBSCRIPTION_KEY',
    client_access_token: 'YOUR_ACCESS_TOKEN',
    api_lang: 'FR',
    api_base_url: 'http://example.com/v1/',
    api_version: 'YYYYMMDD'
)
```

And you also can send additional data to server during request, use second parameter of text_request and voice_request methods for that

```ruby
    response = client.text_request 'Hello', :contexts => ['firstContext'], :resetContexts => true
    response = client.voice_request 'Hello', :timezone => "America/New_York"
```
More information about possible parameters cand be found at https://docs.api.ai/docs/query page






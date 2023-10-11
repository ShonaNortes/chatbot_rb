require 'http'
require 'json'
require 'dotenv'
Dotenv.load

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/engines/text-babbage-001/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

data = {
  "prompt" => "5 parfums de glace",
  "max_tokens" => 10,
  "n" => 1,
  "stop" => ["\n"],
  "temperature" => 0.5
}

response = HTTP.post(url, headers: headers, body: data.to_json)

if response.status.success?
  response_body = JSON.parse(response.body.to_s)
  if response_body['choices'] && response_body['choices'][0] && response_body['choices'][0]['text']
    response_string = response_body['choices'][0]['text'].strip
    puts "Voici 5 parfums de glace :"
    puts response_string
  else
    puts "Réponse inattendue de l'API OpenAI."
  end
else
  puts "La requête HTTP a échoué avec le code de statut : #{response.status.code}"
end
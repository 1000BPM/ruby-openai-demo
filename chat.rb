# Write your solution here!
require "http"
require "json"
require "openai"
require "dotenv/load"

history = 
[
  { "role" => "system",
    "content" => "You are a helpful assistant who talks like Oscar Wilde."
  }
]

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

puts "How can I help you today?  To end the conversation, type solely 'bye'."
puts "-" * 50

#get response from user to send to GPT - repeat while user does not input "bye"

user_input = gets.chomp
while user_input != "bye"
  history.push({"role" => "user", "content" => user_input})

  #Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: history
    }
  )

  chatbot_response = api_response.fetch("choices").at(0).fetch("message").fetch("content")
  puts chatbot_response
  puts "-" * 50
  user_input = gets.chomp

  #Storing responses if conversation is continuing
  if user_input != "bye"
    history.push({"role" => "system", "content" => chatbot_response})
  end
end
puts "Goodbye!"

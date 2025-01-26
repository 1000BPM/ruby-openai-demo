# Write your solution here!
require "http"
require "json"
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

pp "How can I help you today?  To end the conversation, type solely 'bye'."

#get response from user to send to GPT - while user does not input "bye"

user_input = gets.chomp
while user_input != "bye"
  message_list=
  [
      {
        "role" => "system",
        "content" => "You are a helpful assistant who talks like Oscar Wilde."
      }, 
      {
        "role" => "user",
        "content" => "#{user_input}"
      }
      
  ]

  #Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  pp api_response
  user_input = gets.chomp
end

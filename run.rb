require 'pry'
require './lib/canvas'
require './lib/cli'

cli   = Draw::CLI.new
user_input = nil
puts
puts "Welcome to Draw. Please start by creating a canvas."
puts
while user_input != Draw::CLI::Commands::EXIT
  begin
    user_input = gets.chomp
    puts cli.input(user_input)
  rescue Draw::CLI::NoPrefixError
    puts "Prefix your command with #{Draw::CLI::Commands::PREFIX}\n"
  rescue Draw::CLI::UnknownCommandError
    puts "Command must be one of #{Draw::CLI::SHAPE_COMMANDS.keys.join(', ')}\n"
  end
end
puts
puts 'Exiting Draw. Bye!'

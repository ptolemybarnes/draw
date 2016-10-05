require 'pry'
require './lib/canvas'
require './lib/cli'

cli   = Draw::CLI.new
input = nil
puts
puts "Welcome to Draw. Please start by creating a canvas."
puts
while input != 'exit'
  begin
    puts cli.input(gets.chomp)
  rescue Draw::CLI::NoPrefixError
    puts "Prefix your command with #{Draw::CLI::Commands::PREFIX}\n"
  rescue Draw::CLI::UnknownCommandError
    puts "Command must be one of #{Draw::CLI::SHAPE_COMMANDS.keys.join(', ')}\n"
  end
end
puts
puts 'Exiting Draw. Bye!'

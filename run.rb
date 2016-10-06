require './lib/project'
require './lib/cli'

cli = Draw::CLI.new
user_input = nil
puts
puts "Welcome to Draw. Please start by creating a project."
puts
while user_input != Draw::CLI::Commands::EXIT
  begin
    user_input = gets.chomp
    puts cli.input(user_input)
  rescue Draw::CLI::NoPrefixError
    puts "Prefix your command with #{Draw::CLI::Commands::PREFIX}\n"
  rescue Draw::CLI::UnknownCommandError
    puts "Command must be one of #{Draw::CLI::SHAPE_COMMANDS.keys.join(', ')}\n"
  rescue => e
    puts "Draw exploded for the following reason: #{e}"
  end
end
puts
puts 'Exiting Draw. Bye!'

require './analyzing'

url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
analyzing = Analyzing.new(url)

analyzing.speakers
analyzing.lines
analyzing.speaker_line
puts 'List all the speakers?y/n'
ask = gets.chomp
if analyzing.list_yes_or_no?(ask)
  analyzing.list
  puts'Bye, Bye'
elsif !analyzing.list_yes_or_no?(ask)
  puts 'Write the name of the espeaker to see how many lines it says'
  name = gets.chomp
  analyzing.only_one_speaker(name)
  puts'Bye, Bye'
end

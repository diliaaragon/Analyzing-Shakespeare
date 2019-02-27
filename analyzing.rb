require 'Nokogiri'
require 'open-uri'

class Analyzing
  attr_accessor :doc, :libretto

  def initialize(url)
    @doc = Nokogiri::XML(open(url))
    @libretto={}
  end

  def speakers
    @speakers ||= @doc.search('SPEECH').map { |speech| speech.at_xpath('SPEAKER').content }
  end

  def lines
    @lines ||= @doc.search('SPEECH').map { |speech| speech.search('LINE') }
  end

  def speaker_line
    speakers.each.with_index do |speaker, i| 
      if !@libretto.keys.include?("#{speaker}") && speaker != "ALL"
        libretto["#{speaker}"] = lines[i].size
      elsif speakers[i] != "ALL"
        libretto["#{speaker}"] += lines[i].size
      end
    end
  end

  def list
    @libretto.each do |key, value|
      puts "The speaker #{key} has #{value} lines."
    end
  end

  def list_yes_or_no?(ask)
    if ask == 'n'
     return false
    end
    return true
  end

  def only_one_speaker(name)
    libretto.each do |key, value|
      if key == name
        puts "The speaker #{key} has #{value} lines."
      end
    end
  end
end
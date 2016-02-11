#!/usr/bin/env ruby

require 'open-uri'
require 'tempfile'
require 'tesseract'

DESKTOP = '/Users/me/Desktop/'

country_codes = %w(us uk ca nl de hk)

country_codes.each do |code|
  image_url = "http://justfreevpn.com/free-vpn-password/#{code}-free-vpn.gif"
  path = DESKTOP + "#{code}.gif"
  File.open(path, 'wb') do |temp_file|
    open(image_url, 'rb', 'Referer' => 'http://justfreevpn.com/') do |image|
      temp_file.write(image.read)
    end
  end
  `convert #{DESKTOP}/#{code}.gif #{DESKTOP}/#{code}.png`
  e = Tesseract::Engine.new {|e| e.whitelist = (0..9) }
  # Bit crasppy: zeros are left blank, 8 read as 5's..
  puts e.text_for("#{DESKTOP}#{code}.png").chomp
end

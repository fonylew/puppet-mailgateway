#!/usr/local/bin/ruby

require 'net/smtp'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'

print 'To whom? (just nickname)'
name=gets.strip
#####
sender='fon@example.com'
rcpt=name+'@example.com'
subject='guide to the galaxy'
####

print 'How many mail?'
x = gets.strip.to_i
hdate = Time.now.httpdate

page = Nokogiri::HTML(open("http://johno.jsmf.net/knowhow/ngrams/index.php?table=en-galaxy-word-2gram&paragraphs=5&length=500&no-ads=on"))

for i in (1..x) do
message = <<MESSAGE_END
From: Fony<#{sender}>
To: Bob <#{rcpt}>
Subject: #{subject} #  #{i}
Date: #{hdate}
#{page.css('div#text')[0].text}
MESSAGE_END

#jfsaklfjewii123456789cvbnmkfsalssXJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34Xpfowejbdfasiiehrfnvlszxdosp1`0
   if i%2==0		
	Net::SMTP.start('10.10.6.92') do |smtp|
	  smtp.send_message message,sender,rcpt
	end
   else
	Net::SMTP.start('10.10.6.93') do |smtp|
	  smtp.send_message message,sender,rcpt
	end
   end
end

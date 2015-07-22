#!/usr/local/bin/ruby

require 'net/smtp'
require 'time'

sender='fon@example.com'
rcpt='win@example.com'

#####
puts 'How many mail?'
x = gets.strip.to_i
puts 'from:'
sender=gets.strip
puts 'to:'
rcpt=gets.strip
puts 'subject:'
subject=gets.strip
puts 'body:'
body=gets.strip
hdate = Time.now.httpdate

for i in (1..x) do
message = <<MESSAGE_END
From: Fony<#{sender}>
To: Bob <#{rcpt}>
Subject: #{subject}  #{i}
Date: #{hdate}
#{body}
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

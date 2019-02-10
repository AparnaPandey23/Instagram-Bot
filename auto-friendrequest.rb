require 'watir'
require_relative './credentials' #[in same folder]

#storing the user details in variables from credentials.rb 
username = $username;
password = $password;

#-------------------------------Initial log in----------------------------------------------------------#

#Open browser , navigate to login page 
caps = Selenium::WebDriver::Remote::Capabilities.chrome
caps[:chrome_options] = {detach: true}
browser = Watir::Browser.new :chrome, desired_capabilities: caps
browser.goto "instagram.com/accounts/login/" 

# Navigate to username and password fields and inject info
puts "Logging in.."
browser.text_field(:name =>"username").set "#{username}"
browser.text_field(:name =>"password").set "#{password}"

# Click log in button
# browser.button(:class => "_0mzm- sqdOP  L3NKy").click
browser.button(:class => "_0mzm- sqdOP  L3NKy  ".split).click
sleep(2)

#opens my page 
puts "Logged in successfully"

# If Turn On Notifications modal is present, we close it
if browser.div(:class => ['pbNvD', 'fPMEg']).exists?
    browser.button(:class => ['aOOlW', 'HoLwm']).click
end

#------------------------------------Managing user's Friend Requests----------------------------------------------------#
#click on activity feed
browser.link(:class => ["_0ZPOP", "kIKUG"]).click
sleep(2)
#click on follow requests
browser.button(:class => "M_9ka").click
sleep(2)
#viewing the most recent follow request. -> go to users page and come back then confirm or delete request
browser.link(:class =>["FPmhX", "notranslate" ,"yrJyr"]).click
sleep(3)

user = browser.h1(:class => ["_7UhW9","fKFbl", "yUEEX"  , "KV-D4","fDxYl"]).text
puts "Friend request from : #{user}"

#repeat steps above to look at requests again
#click on activity feed
browser.span(:class => ["glyphsSpriteHeart__outline__24__grey_9", "u-__7"]).click
sleep(2)
#click on follow requests
browser.button(:class => "M_9ka").click
sleep(2)

#confirm
browser.button(:class =>"_0mzm- sqdOP  L3NKy",text: "Confirm").click 
puts "Confirming friend request from #{user}" 
#or delete
browser.button(:class => ["_0mzm-", "sqdOP", "L3NKy", "_8A5w5"] ,text: "Delete").click
puts "Deleting friend request  from #{user}"




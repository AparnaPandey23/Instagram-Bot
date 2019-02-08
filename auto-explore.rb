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

#------------------------------------Explore automation----------------------------------------------------#
likes = 0
round = 0
MAX_LIKES = 10

# Loop through explore page
if round < 5  #refresh page 5 times after maxlikes number of pics are liked
    browser.goto "instagram.com/explore/"
    sleep(5)
    if likes < MAX_LIKES #like 10 pics on page then refresh
        browser.div(:class => "_9AhH0").click
        sleep(3)
        
        10.times do 
        #like the picture if not already
        if browser.button(:class => ["coreSpriteHeartOpen", "oF4XW", "dCJp8"]).exists?
            browser.button(:class => ["coreSpriteHeartOpen", "oF4XW", "dCJp8"]).click
            likes += 1
            sleep(1)
        elsif browser.button(:class => ["dCJp8", "afkep", "coreSpriteHeartOpen", "_0mzm-"]).exists?
             browser.button(:class => ["dCJp8", "afkep", "coreSpriteHeartOpen", "_0mzm-"]).click
            sleep(2)
        end
        #move to next pic
        browser.a(:class => ["HBoOv", "coreSpriteRightPaginationArrow"]).click
        sleep(2)
        end
    end
    round += 1
    puts "Photos liked: #{likes} in round : #{round} "
end
puts "Done liking pictures"
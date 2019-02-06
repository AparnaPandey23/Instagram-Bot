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

#-----------------------------------------Liking pictures in a specific hashtag----------------------------------------------------#

tag = "#artJournal"

#clicks on search bar and then looks for hashtag
browser.text_field(:class => ["XTCLo", "x3qfX"]).set "#{tag}" 
sleep(1)

#as tag in url doesnt require the "#" character remove it
tag = "artJournal"
#goes to specific users profiles
browser.goto "instagram.com/explore/tags/#{tag}/"


likes =0 
browser.div(:class => ["Nnq7C","weEfm"]).click

while likes < 5 do
    #like the picture
    if browser.button(:class =>["dCJp8", "afkep", "coreSpriteHeartOpen", "_0mzm-"]).exists?
        browser.button(:class =>["dCJp8", "afkep", "coreSpriteHeartOpen", "_0mzm-"]).click
        likes += 1
    #wait for 3 seconds
    sleep(3)
    # move to next picture
        if browser.link(:class =>["HBoOv", "coreSpriteRightPaginationArrow"]).exists?
            browser.link(:class =>["HBoOv", "coreSpriteRightPaginationArrow"]).click
        end
    end
end
puts "Photos liked: #{likes}" 
#click the little x on top right corner
browser.button(:class => "ckWGn").click
sleep(2)

#follow the tag if not following it already
if browser.button(:class =>"_0mzm- sqdOP  L3NKy _4pI4F").exists?
    browser.button(:class =>"_0mzm- sqdOP  L3NKy _4pI4F").click
#unfollow otherwise
elsif browser.button(:class =>"_0mzm- sqdOP  L3NKy _4pI4F  _8A5w5").exists?
    browser.button(:class =>"_0mzm- sqdOP  L3NKy _4pI4F  _8A5w5").click
end

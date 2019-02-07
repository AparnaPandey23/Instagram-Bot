require 'watir'
require_relative './credentials' #[in same folder]

#storing the user details in variables from credentials.rb 
username = $username;
password = $password;

#-------------------------------Initial log in---------------------------------------------------------------------------------------------#

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
#--------------------------------------Commenting on a users Post------------------------------------------------------------------------------------------#
#for each picture
browser.div(:class => ["Nnq7C","weEfm"]).click
comments  = 0
while comments < 5 do #will post 5 comments on one post. it is possible to move to next post but additional code is required to do so
    if browser.span(:class => ["glyphsSpriteComment__outline__24__grey_9","u-__7"],aria_label:"Comment").exists?
        browser.span(:class => ["glyphsSpriteComment__outline__24__grey_9","u-__7"],aria_label:"Comment").click
        #scrolling to the bottom of window
        browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
        #enter a comment
        sleep(1)
        browser.textarea(:class => "Ypffh").set "🥰"
        #Post the comment
        sleep(1)
        browser.button(:class => ["_0mzm-", "sqdOP", "yWX7d"]).click
        comments = comments +1
    end
end

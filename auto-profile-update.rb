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

#-------------------------------Updating User Profile----------------------------------------------------------#
#go to profile from homepage
browser.span(:class =>["glyphsSpriteUser__outline__24__grey_9", "u-__7"],aria_label: "Profile").click
sleep(1)

#click on edit profile
browser.button(:class =>["_0mzm-", "sqdOP", "L3NKy", "_4pI4F", "_8A5w5"]).click
sleep(1)

userdet = browser.text_field(id:"pepName").value
puts "Changing user bio"
browser.textarea(id:"pepBio").set "Hey I am #{userdet} and i dont have a Bio. Woop Woop"
sleep(2)
#scrolling to the bottom of window
browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
#clicking submit
browser.button(:class =>["_0mzm-", "sqdOP", "L3NKy"]).click
puts  "Profile successfully updated"
sleep(2)

#try to change profile picture 
browser.button(:class => "IalUJ ").click
sleep(1)
#cancel
browser.button(:class => ["aOOlW","HoLwm "]).click
sleep(1)

#return to profile
browser.span(:class =>["glyphsSpriteUser__outline__24__grey_9", "u-__7"],aria_label: "Profile").click
sleep(1)


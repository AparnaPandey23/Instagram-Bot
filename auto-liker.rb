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
browser.button(:class => "_0mzm- sqdOP  L3NKy  ".split).click
sleep(2)

#opens my page 
puts "Logged in successfully"

# If Turn On Notifications modal is present, we close it
if browser.div(:class => ['pbNvD', 'fPMEg']).exists?
    browser.button(:class => ['aOOlW', 'HoLwm']).click
end
#-----------------------------------Scrolling through homepage and liking pics----------------------------------------------------------#

# defining defaults
like_counter = 0
num_rounds = 0
MAX_LIKES = 10
 
sleep(2)
loop do
    # do the scrolling 3 
    3.times do |i| browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)") #used to scroll on the homepage 
    sleep(1)
end

if browser.span(:class => ["glyphsSpriteHeart__outline__24__grey_9", "u-__7"],aria_label:"Like").exists? #checks if like button exists.. if it does click it
    browser.spans(:class => ["glyphsSpriteHeart__outline__24__grey_9", "u-__7"],aria_label:"Like").each { |val|
      val.click
      like_counter += 1
    }
    puts "Photos liked: #{like_counter}" #used to keep track of likes
else
    puts "No media to like right now"
end
num_rounds += 1
puts "--------- #{like_counter / num_rounds} likes per round (on average) ----------"

break if like_counter > MAX_LIKES #stop liking pictures if counter exceeds limit specified
  sleep(2) # Return to top of loop after this many seconds to check for new photos
  puts "Exit the auto-liker loop"
end
#-----------------------------------------End--------------------------------------------------------------------------------------#







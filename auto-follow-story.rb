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



#--------------------------------------Following/ Unfollowing User------------------------------------------------------------------------------------------#
#user we are going to spam
user = "dog" 

sleep(2)
#clicks on search bar and then looks for user
browser.text_field(:class => ["XTCLo", "x3qfX"]).set "#{user}" 
sleep(1)

# # goes to specific users profiles DO:
# browser.goto "instagram.com/#{user}/"
# #or 

#suggestion div opens up and then select specific span with text = username whose page we need to visit
browser.span(:class =>"Ap253",text: "#{user}").click

#following and unfollowing selected user
if browser.button(:class => [ "_5f5mN" , "jIbKX",  "_6VtSN",  "yZn4P "]).exists?  #not following currently
    browser.button(:class => [ "_5f5mN" , "jIbKX",  "_6VtSN",  "yZn4P "]).click #follow them then
    puts("\n Following #{user}...\n\n")
    sleep(1)
elsif browser.button(:class => ["_5f5mN",   "-fzfL",   "_6VtSN",   "yZn4P"]).exists?  #following user currently
    browser.button(:class => ["_5f5mN",   "-fzfL",   "_6VtSN",   "yZn4P"]).click  #unfollow user then
    sleep(1)
    #click confirm button if asked 
    if browser.button(:class => ["aOOlW" ,"-Cab_"]).exists?
    browser.button(:class => ["aOOlW" ,"-Cab_"]).click 
    end
    puts("\n Unfollowing #{user}...\n\n")
end 

sleep(2)

#--------------------------------------Liking pictures ------------------------------------------------------------------------------------------#
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

#after either following or unfollowing user return to your home page to like pages
if browser.div(:class => ["oJZym"]).exists?
    browser.div(:class => ["oJZym"]).click
end

#-----------------------------------------Watching story for 30 seconds/ Reporting it (not really) and then closing it---------------------------------------------------------------------------------------#
sleep(2)
if browser.a(:class => ["_0mzm-", "sqdOP", "yWX7d", "_8A5w5","ZIAjV"]).exists?
    browser.a(:class => ["_0mzm-", "sqdOP", "yWX7d", "_8A5w5","ZIAjV"]).click
end
puts("\n Watching stories for 30 seconds...")
sleep(30)
#try reporting a story but cancel because you are nice
if browser.span(:class =>["glyphsSpriteMore_horizontal__filled__24__grey_0", "u-__7"]).exists?
     browser.span(:class =>["glyphsSpriteMore_horizontal__filled__24__grey_0", "u-__7"]).click
     sleep(2)    
     browser.button(:class=> ["aOOlW", "HoLwm"],text:"Cancel").click #need this as there are 2 buttons with same class and details apart from the fact that they have different text fields
end
sleep(2)
if browser.div(:class => "coreSpriteCloseLight").exists?
    browser.div(:class => "coreSpriteCloseLight").click
end
#-----------------------------------------End--------------------------------------------------------------------------------------#


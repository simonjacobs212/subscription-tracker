Category.destroy_all
Service.destroy_all
User.destroy_all
Reminder.destroy_all
Subscription.destroy_all
ServiceCategory.destroy_all

Category.reset_pk_sequence
Service.reset_pk_sequence
User.reset_pk_sequence
Reminder.reset_pk_sequence
Subscription.reset_pk_sequence
ServiceCategory.reset_pk_sequence

################# creating categories  ##################### 

video = Category.create(type: "video streaming")
music = Category.create(type: "music streaming")
e_com = Category.create(type: "e-commerce")
gaming = Category.create(type: "gaming")
live_tv = Category.create(type: "live tv")

################# creating services  ##################### 

netflix = Service.create(name: "netflix", url: "netflix.com")
hulu = Service.create(name: "hulu", url: "hulu.com")
amazon = Service.create(name: "amazon", url: "amazon.com")
disney_plus = Service.create(name: "disney+", url: "disneyplus.com")
spotify = Service.create(name: "spotify", url: "spotify.com")
pandora = Service.create(name: "pandora", url: "pandora.com")
ebay = Service.create(name: "ebay", url: "ebay.com")
twitch = Service.create(name: "twitch", url: "twitch.com")
wow = Service.create(name: "world of warcraft", url: "worldofwarcraft.com")

################# creating users  #####################

john = User.create(first_name: "john", last_name: "smith")
mary = User.create(first_name: "mary", last_name: "howard")
chris = User.create(first_name: "chris", last_name: "johnson")
shelly = User.create(first_name: "shelly", last_name: "lansing")

################# creating service categories  #####################

netflix.categories << video
hulu.categories << video, live_tv
amazon.categories << e_com, video, music, live_tv
disney_plus.categories << video
spotify.categories << music
pandora.categories << music
ebay.categories << e_com
twitch.categories << video
wow.categories << gaming

################# creating service categories  #####################

puts "🔥 🔥 it's lit 🔥 🔥 "
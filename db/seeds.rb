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

video = Category.create(name: "video streaming")
music = Category.create(name: "music streaming")
e_com = Category.create(name: "e-commerce")
gaming = Category.create(name: "gaming")
live_tv = Category.create(name: "live tv")

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
xbox = Service.create(name: "xbox live", url: "xbox.com")

################# creating users  #####################

john = User.create(first_name: "john", last_name: "smith")
mary = User.create(first_name: "mary", last_name: "howard")
chris = User.create(first_name: "chris", last_name: "johnson")
shelly = User.create(first_name: "shelly", last_name: "lansing")

################# creating service categories  #####################

netflix.categories << video
hulu.categories << [video, live_tv]
amazon.categories << [e_com, video, music, live_tv]
disney_plus.categories << video
spotify.categories << music
pandora.categories << music
ebay.categories << e_com
twitch.categories << video
wow.categories << gaming
xbox.categories << [gaming, video]

################# creating subscriptions  #####################
s1 = Subscription.create(service_id: netflix.id, email: "jsmith@gmail.com", user_id: john.id, duration: 30, cost_per_duration: 0)
s2 = Subscription.create(service_id: amazon.id, email: "jsmith@gmail.com", user_id: john.id, duration: 365, cost_per_duration: 119.00)
s3 = Subscription.create(service_id: disney_plus.id, email: "jsmith@gmail.com", user_id: john.id, duration: 365, cost_per_duration: 69.99)
s4 = Subscription.create(service_id: wow.id, email: "jsmith@gmail.com", user_id: john.id, duration: 30, cost_per_duration: 14.99)
s5 = Subscription.create(service_id: spotify.id, email: "mhoward12@gmail.com", user_id: mary.id, duration: 30, cost_per_duration: 9.99)
s6 = Subscription.create(service_id: pandora.id, email: "mhoward12@gmail.com", user_id: mary.id, duration: 30, cost_per_duration: 4.99)
s7 = Subscription.create(service_id: hulu.id, email: "videolover13@gmail.com", user_id: chris.id, duration: 30, cost_per_duration: 54.99)
s8 = Subscription.create(service_id: netflix.id, email: "videolover13@gmail.com", user_id: chris.id, duration: 365, cost_per_duration: 168.00)
s9 = Subscription.create(service_id: pandora.id, email: "videolover13@gmail.com", user_id: chris.id, duration: 30, cost_per_duration: 4.99)
s10 = Subscription.create(service_id: xbox.id, email: "videolover13@gmail.com", user_id: chris.id, duration: 90, cost_per_duration: 24.99)
s11 = Subscription.create(service_id: ebay.id, email: "mhoward12@gmail.com", user_id: mary.id, duration: 30, cost_per_duration: 21.95)

################ creating reminders ############################

######### John has 1 active reminder, 3 inactive
r1 = Reminder.create(user_id: john.id, subscription_id: s1.id, active: true)
r2 = Reminder.create(user_id: john.id, subscription_id: s2.id, active: false)
r3 = Reminder.create(user_id: john.id, subscription_id: s3.id, active: false)
r4 = Reminder.create(user_id: john.id, subscription_id: s4.id, active: false)

######### Mary has reminders for all ###############
r4 = Reminder.create(user_id: john.id, subscription_id: s5.id, active: true)
r4 = Reminder.create(user_id: john.id, subscription_id: s6.id, active: true)
r4 = Reminder.create(user_id: john.id, subscription_id: s11.id, active: true)

###

puts "🔥 🔥 it's lit 🔥 🔥 "
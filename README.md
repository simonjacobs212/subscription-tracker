# Subscription Tracker
![](due_date_on_calendar.jpeg)
## Welcome to Subscription Tracker! 
This app is designed to keep tracker of your free and paid subscriptions such as Netflix, Amazon, Spotify, and more. As the renewal dat for your subscription comes close, or your free trial is about to end, this app will alert you. By default, notifications will be issues 7 days in advance of the renewal date. This will give you one week to either cancel your subscription, end your free trial, or be prepared to pay for the renewal.

---
## Table of Contents
* [1. Using the App](#1-usage)
  * [1.1 Launching the App](#11-launching-the-app)
  * [1.2 Logging In](#12-logging-in)
    * [1.2.1 New Users](#121-new-users)
    * [1.2.2 Existing Users](#122-existing-users)
  * [1.3 App Features](#13-app-features)
    * [1.3.1 My Subscriptions](#131-my-subscriptions)
      * [1.3.1.1 Viewing Subscriptions](#1311-viewing-subscriptions)
      * [1.3.1.2 Adding New Subscriptions](#1312-adding-new-subscriptions)
      * [1.3.1.3 Update Subscription](#1313-update-subscription)
      * [1.3.1.4 Delete Subscription](#1314-delete-subscription)
      * [1.3.1.5 Access Reminders](#1315-access-reminders)
    * [1.3.2 Reminders](#132-reminders)
      * [1.3.2.1 Change Days Notice](#1321-change-days-notice)
      * [1.3.2.2 Disable Reminder](#1322-disable-reminder)
* [2. App Design](#2-app-design)
  * [2.1 Domain Model (ERD)](#21-domain-model-(erd))
  * [2.2 Model Associations](#22-model-associations)
  * [2.3 Interface Modules](#23-interface-modules)
  * [2.4 Stretch Goals](#24-stretch-goals)
---
### 1. Using the App
#### 1.1 Launching the App
To launch the app, navigate to the parent directory.

Use the rake command `rake start` in the terminal to launch the app.

#### 1.2 Logging In
##### 1.2.1 New Users
If you have not previously made an account with SubscriptionTracker, select <strong>New User</strong> from the main menu.
* The app will ask you for your first and last name, as well as a username and password in order to create an account.
* If the username you have selected is already in use, you will be prompted to pick a new username
##### 1.2.2 Existing Users
If you have previously made an account with Subscriptiontracker, enter the username and password that you selected when you made the account.
#### 1.3 App Features
Use the main menu to navigate through the app. The major features are described individualy below.
##### 1.3.1 My Subscriptions
##### 1.3.1.1 Viewing Subscriptions
If you have already added subscriptions to you SubscriptionTracker account, selecting <strong>My Subscriptions</strong> will display a menu of all of your current subscriptions and the subscription details such as cost, duration, and renewal date. 
* Pressing `enter` on any of the current subscriptions will select that subscription and allow you to:
  * [Update the subscription](#1313-update-subscription) details such as cost or plan duration.
  * Set up or modify the [reminder](#132-reminders) for this subscription.
* Below the list of subscriptions, or if you have not already added some, you will see an option to [add a new subscription](#1312-adding-new-subscriptions).

##### 1.3.1.2 Adding New Subscriptions
Selecting this option will allow you to add a new subscription to your SubscriptionTracker account.
* A list of subscription services currently linked to this app will be displayed in a menu. Select the service which you are subscribed to in order to begin tracking it in the app.
  * Hint: Begin typing the first few letters of the service name in order to filter the list.
* Upon selecting a service, you will need to enter all of the following in order to track the subscription on the app:
  * <strong>Email Address:</strong> Enter the email address that you used to create the subscription. If you have multiple accounts or subscriptions to the same service, be sure to use the correct email address for each subscription you are associating with your SubscriptionTracker account.
  * <strong>Subscription Duration:</strong> Enter the duration of the subscription plan in days.
    * For a recurring 1 month subscription, enter `30`
    * For a recurring 3 month subscription, enter `90`
    * For a recurring 1 year subscription, enter `365`
  * <strong>Cost of Subscription:</strong> Enter the cost of the subscription per the recurring duration. For example, if you have a monthly plan, enter the monthly cost. If you have an annual plan, enter the annual cost.
    * The cost <strong>must</strong> be entered in standard monetary format, without the dollar sign.
      * Ex: $5 should be entered as 5.00
* After successfully adding a new subscription to your SubscriptionTracker Account, it will automatically give you the option to [setup a new reminder](#132-reminders)

##### 1.3.1.3 Update Subscription





      * [1.3.1.4 Delete Subscription](#1314-delete-subscription)
      * [1.3.1.5 Access Reminders](#1315-access-reminders)
    * [1.3.2 Reminders](#132-reminders)
      * [1.3.2.1 Change Days Notice](#1321-change-days-notice)
      * [1.3.2.2 Disable Reminder](#1322-disable-reminder)
* [2. App Design](#2-app-design)
  * [2.1 Domain Model (ERD)](#21-domain-model-(erd))
  * [2.2 Model Associations](#22-model-associations)
  * [2.3 Interface Modules](#23-interface-modules)
  * [2.4 Stretch Goals](#24-stretch-goals)































<!-- User Stories (remember about CRUD):

E.g. User will be able to:
<!-- Change Name -->
<!-- Make a new subscription
<!-- View subscriptions -->
<!-- Change subscription cost
Change subscription duration
Delete subscription -->
<!-- Delete User’s app account & data -->
<!-- Create new service -->
<!-- Update service categories --> -->
<!-- Create/View/Disable reminders -->
<!-- Change how far in advance reminder is issued -->
<!-- Delete reminder (with warning) -->
<!-- Create new service category if it doesn’t exist --> -->

MVP+
View spending by category and/or service

<!-- Develop Schema & Associations & Seed  - done
Develop CRUD methods - done
Develop CLI Interface - WIP -->

Begin stretch goals:
log into the application or make new account
Delete User’s app account & data
View spending by category and/or service
Change username
Change password
Use Twilio to send Reminder, If applicable Calendar API
Build tests for methods



### 1. Using the App {#1-usage}
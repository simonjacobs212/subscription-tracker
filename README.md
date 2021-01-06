<h1 style="color:green; text-align: center">Subscription Tracker</h1>
<p></p>
<img src="due_date_on_calendar.jpeg" style="display:block;margin-left:auto;margin-right:auto">

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
    * [1.3.2 Spending Analyzer](#132-spending-analyzer)
    * [1.3.3 Reminders](#133-reminders)
      * [1.3.3.1 Change Days Notice](#1331-change-days-notice)
      * [1.3.3.2 Disable Reminder](#1332-disable-reminder)
    * [1.3.4 User Settings](#134-user-settings)
      * [1.3.4.1 Change SubscriptionTracker Username](#1341-change-subscriptiontracker-username)
      * [1.3.4.2 Change SubscriptionTracker Password](#1342-change-subscriptiontracker-password)
* [2. App Design](#2-app-design)
  * [2.1 Domain Model (ERD)](#21-domain-model-erd) 
  * [2.2 Model Associations](#22-model-associations)
  * [2.3 Interface Modules](#23-interface-modules)
  * [2.4 MVP](#24-mvp)
    * [2.4.1 User](#241-user)
    * [2.4.2 Subscription](#242-subscription)
    * [2.4.3 Service](#243-service)
    * [2.4.4 Reminder](#244-reminder)
    * [2.4.5 Seeds](#245-seeds)
    * [2.4.6 CLI](#245-cli)
  * [2.5 Stretch Goals](#24-stretch-goals)
    * [2.5.1 README in Markdown](#251-readme-in-markdown)
    * [2.5.2 User Login System](#252-user-login-system)
    * [2.5.3 Modularize Main App](#253-modularize-main-app)
    * [2.5.4 Reminders link to User's Calendar App](#254-reminders-link-to-user's-calendar-app)
---
## 1. Using the App
### 1.1 Launching the App
To launch the app, navigate to the parent directory.

Use the rake command `rake start` in the terminal to launch the app.

### 1.2 Logging In
#### 1.2.1 New Users
If you have not previously made an account with SubscriptionTracker, select <strong>New User</strong> from the main menu.
* The app will ask you for your first and last name, as well as a username and password in order to create an account.
* If the username you have selected is already in use, you will be prompted to pick a new username
#### 1.2.2 Existing Users
If you have previously made an account with Subscriptiontracker, enter the username and password that you selected when you made the account.
### 1.3 App Features
Use the main menu to navigate through the app. The major features are described individualy below.
#### 1.3.1 My Subscriptions
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
After selecting a current subsction, choose <strong>Update/Delete Subscription</strong> from the subscription menu.
* In order to update the details of your subscription plan such as cost or plan duration, select <strong>Update cost/duration</strong> from the next menu
* When updating the plan details, ensure to follow all of the smae guidelines for entering the cost and plan duration that you followed when initially creating the subscription. Those details are listed below again for your convenience.
  * <strong>Subscription Duration:</strong> Enter the duration of the subscription plan in days.
    * For a recurring 1 month subscription, enter `30`
    * For a recurring 3 month subscription, enter `90`
    * For a recurring 1 year subscription, enter `365`
  * <strong>Cost of Subscription:</strong> Enter the cost of the subscription per the recurring duration. For example, if you have a monthly plan, enter the monthly cost. If you have an annual plan, enter the annual cost.
    * The cost <strong>must</strong> be entered in standard monetary format, without the dollar sign.
      * Ex: $5 should be entered as 5.00

##### 1.3.1.4 Delete Subscription
After selecting a current subsction, choose <strong>Update/Delete Subscription</strong> from the subscription menu.
* In order to delete a subscription plan from your SubscriptionTracker app acount, select <strong>Delete Subscription</strong> from the next menu
  * <span style= "color:rgba(139, 0, 0, 1)">:warning: Warning: Deleting a subscription is irreversible. :warning:</span> 

##### 1.3.1.5 Access Reminders
Selecting <strong>Access Reminder</strong> from the subscription menu will display the date on which the reminder for that subscription will be issued.
* If no reminder has yet been set, you will be asked if you would like to create a new one.
* After displaying the reminder, you will have the option to adjust how much advance notice the reminder provides, or to disable the reminder.

#### 1.3.2 Spending Analyzer
Selecting this menu option will provide an analysis of your current spending based upon the <strong>current</strong> costs of your subscriptions as well as the durations for each of your subscriptions
* Daily spending report presents a normalized report for the cost of the users current subscriptions per day
  * This is helpful for comparison to common daily expenditures such as a coffee or buying lunch out.
* Monthly spending report assumes that all current subscriptions will be maintained for at least 30 days
* Yearly spending report assumes that all current subscriptions will be maintained for 365 days
* Cost by category will present your will a breakdown of how much the user spends <strong>per day</strong> on each of the categories that their services belong to. Use this to look for areas in which you many be overspending.
* Duplicate Subscriptions report will highlight services for which you have multiple current subscriptions and the amount of money that could be saved by eliminating all but one.

#### 1.3.3 Reminders
##### 1.3.3.1 Change Days Notice
Here you can change how much notice the reminder will give before the renewal.
* Enter the number of <strong>days</strong> notice you would like.date for your subscription is scheduled.
  * For example, if your subscription is set to renew on Jan 20, a 7 day advance notice means that a reminder will be set for Jan 13.

##### 1.3.3.2 Disable Reminder
Selecting this option will allow you to disable the current reminder for a subscription.
* <span style= "color:rgba(139, 0, 0, 1)">:warning: Warning: Deleting a subscription is irreversible. :warning:</span> 
  * If you would like to re-enable a reminder, you must [create a new one](#1315-access-reminders).

#### 1.3.4 User Settings
##### 1.3.4.1 Change SubscriptionTracker Username
This will allow you to change the username that you use to log in to the SubscriptionTracker application. Please note that this does not change the username for your subscription services.
##### 1.3.4.2 Change SubscriptionTracker Password
This will allow you to change the password which you use to log in to the SubscriptionTracker application. Please note that this does not change the password for any of your subscription services.

## 2. App Design
### 2.1 Domain Model (ERD)
![](Subscriptiontracker_ERD.png)
### 2.2 Model Associations
* A Category 
  * has many ServiceCategories
  * has many Services through ServiceCategories
* A ServiceCategory
  * belongs to a Category
  * belongs to a Service
* A Service
  * has many ServiceCategories
  * has many Categories through ServiceCategories
  * has many Subscriptions
  * has many Reminders through Subscriptions
  * has many users through subscriptions
* A Subscription
  * belongs to a Service
  * belongs to a User
  * has many Reminders
* A Reminder
  * belongs to Subscription
* A User
  * has many Reminders
  * has many Subscriptions
  * has many Service through Subscriptions

### 2.3 Interface Modules

### 2.4 MVP
#### 2.4.1 User
User will be able to:
* :white_check_mark: Create a new subscription for themselves 
* :white_check_mark: View their current subscriptions
* :white_check_mark: Modify their current subscription (cost/duration)
* :white_check_mark: Delete their subscription(s)
* :x: View subscription spending:
  * By day
  * By month
  * By year
  * By category
  * By most expensive service
  * Wasted money due to duplicate subscriptions

#### 2.4.2 Subscription
Subscriptions will be able to:
* :white_check_mark: Initialize a renewal date based on date created and plan duration
* :white_check_mark: Update renewal dates when plan details change
* :white_check_mark: Display subscription information
* :white_check_mark: Calculate days remaining in the current plan
* :white_check_mark: Determine if there is a current active reminder
* :white_check_mark: Find ts active reminder
* :white_check_mark: Create a new reminder (which disables the previous one if it was active)
* :white_check_mark: Calculate a normalized cost (dollar per day)

#### 2.4.3 Service
Services will be able to: 
* :white_check_mark: Associate with new or multiple categories

#### 2.4.4 Reminder
Reminders will be able to:
* :white_check_mark: Initialize with a default notice time of 7 days
* :white_check_mark: Find the date on which the reminder should be issues based on `:days_notice` and its subscription's renewal date

#### 2.4.5 Seeds
* :white_check_mark: Develop comprehensive seed data for app creation to test various aggregate methods and associations.
* :white_check_mark: Multiple scenarios accounted for such as:
  * Users with no subscriptions
  * Users with multiple subscriptions to the same service
  * Free trials vs. paid subscriptions
  * Active reminders, old reminders, no reminders

#### 2.4.6 CLI
* :white_check_mark: Develop basic command line interface for user to manage & control app

### 2.5 Stetch Goals
#### 2.5.1 README in Markdown 
Status: :white_check_mark:
You are reading it :smiley:

#### 2.5.2 User Login System
Status: :white_check_mark:
* Develop system to track app users by username and password to persist subscription information between sessions (See [1.2 Logging In](#12-logging-in))
* Validation system developed to ensure no duplicate usernames are created by multiple users
* Validation system developed to ensure masked passwords match prior to account creation
* User has the ability to delete their app account and data

#### 2.5.3 Modularize Main App
Status: :white_check_mark:
* SubscriptionTracker.rb refactored to that main menu options and features exist in their own modules.
* Modules are associated using heirarchy from children up through parents in order to module inclusion to be complete. (See [2.3 Interface Modules](#23-interface-modules))

#### 2.5.4 Reminders link to User's Calendar App 
Status: :x:







Begin stretch goals:
log into the application or make new account
Delete User’s app account & data
View spending by category and/or service
Change username
Change password
Use Twilio to send Reminder, If applicable Calendar API
Build tests for methods


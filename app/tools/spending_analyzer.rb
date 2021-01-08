module SpendingAnalyzer 
    include CliControls

    def spending_summary
        custom_clear
        choices = ["View Overall Spending", "View Spending by Category", "View Most Expensive Subscription", "Back", "Logout"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when "View Overall Spending"
            custom_clear 
            @user.subscriptions.empty? ? no_subscription_alert : overall_spending_summary 
            spending_summary
        when "View Spending by Category"
            custom_clear
            @user.subscriptions.empty? ? no_subscription_alert : display_spending_by_category 
            spending_summary
        when "View Most Expensive Subscription"
            custom_clear
            @user.subscriptions.empty? ? no_subscription_alert : display_most_expensive_subscription
            spending_summary
        when "Back"
            custom_clear
            main_menu
        when "Logout"
            custom_clear
            run
        end
    end

    def no_subscription_alert
        puts "⚠️ You do not have any subscriptions.".yellow
        play_warning_sound
        @@prompt.keypress("Press space or enter to return to Spending Summary", keys: [:space, :return])
    end

    def overall_spending_summary
        rows = [
            ["Per Day:","$#{sprintf('%.2f', @user.spending_per_day.round(2))}".light_green],
            ["Per Month:","$#{sprintf('%.2f', @user.spending_per_month.round(2))}".light_green],
            ["Per Year:", "$#{sprintf('%.2f', @user.spending_per_year.round(2))}".light_green]
            ]
        puts "Spending Summary"
        puts "\n"
        table = TTY::Table.new(["Total Spending".green, "Price".green], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @user.budget_alerts if @user.has_budget?
        puts "\n"
        @@prompt.keypress("Press space or enter to return to the Spending Summary menu.", keys: [:space, :return])
    end

    def display_most_expensive_subscription
        custom_clear
        rows = [
            ["Day:","$#{sprintf('%.2f', @user.most_expensive_subscription.normalize_cost.round(2))}".light_green],
            ["Month:","$#{sprintf('%.2f', (@user.most_expensive_subscription.normalize_cost * 30).round(2))}".light_green],
            ["Year:", "$#{sprintf('%.2f', (@user.most_expensive_subscription.normalize_cost * 365).round(2))}".light_green]
            ]
        puts "Your most expensive subscription is: #{@user.most_expensive_subscription.service.name}."
        puts "\n"
        table = TTY::Table.new(["Cost per".green,"Price".green], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @@prompt.keypress("Press space or enter to return to the Spending Summary menu.", keys: [:space, :return])
    end

    def display_spending_by_category
        rows = @user.daily_spending_by_category.each_with_object([]) do |(category, price), new_array|
            new_array << [category, "$#{sprintf('%.2f', (price * 30).round(2))}".light_green, "$#{sprintf('%.2f', (price * 365).round(2))}".light_green]
        end
        puts "Please note some of your services may have multiple categories.".yellow 
        puts "This may potentially result in exact duplicate costs.".yellow
        puts "\n"
        table = TTY::Table.new(["Category".green,"Monthly Cost".green,"Yearly Cost".green], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @@prompt.keypress("Press space or enter to return to the Spending Summary menu.", keys: [:space, :return])
    end

    
end
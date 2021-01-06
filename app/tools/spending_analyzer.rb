module SpendingAnalyzer 
    
    include CliControls

    def spending_summary
        system 'clear'
        choices = ["View Overall Spending", "View Spending by Category", "View Most Expensive Subscription", "Back", "Logout"]
        selection = @@prompt.select("What would you like to do?", choices)
        case selection
        when "View Overall Spending"
            system 'clear' 
            overall_spending_summary
            spending_summary
        when "View Spending by Category"
            system 'clear'
            display_spending_by_category
            spending_summary
        when "View Most Expensive Subscription"
            system 'clear'
            display_most_expensive_subscription
            spending_summary
        when "Back"
            system 'clear'
            main_menu
        when "Logout"
            system 'clear'
            run
        end
    end

    def overall_spending_summary
        rows = [
            ["Per Day:","$#{sprintf('%.2f', @user.spending_per_day.round(2))}"],
            ["Per Month:","$#{sprintf('%.2f', @user.spending_per_month.round(2))}"],
            ["Per Year:", "$#{sprintf('%.2f', @user.spending_per_year.round(2))}"]
            ]
        puts "Spending Summary"
        puts "\n"
        table = TTY::Table.new(["Total Spending","Price"], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    end

    def display_most_expensive_subscription
        system 'clear'
        rows = [
            ["Day:","$#{sprintf('%.2f', @user.most_expensive_subscription.normalize_cost.round(2))}."],
            ["Month:","$#{sprintf('%.2f', (@user.most_expensive_subscription.normalize_cost * 30).round(2))}."],
            ["Year:", "$#{sprintf('%.2f', (@user.most_expensive_subscription.normalize_cost * 365).round(2))}."]
            ]
        puts "Your most expensive subscription is: #{@user.most_expensive_subscription.service.name}."
        puts "\n"
        table = TTY::Table.new(["Cost per","Price"], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    end

    def display_spending_by_category
        rows = @user.daily_spending_by_category.each_with_object([]) do |(category, price), new_array|
            new_array << [category, "$#{sprintf('%.2f', (price * 30).round(2))}", "$#{sprintf('%.2f', (price * 365).round(2))}"]
        end
        puts "Please note some of your services may have multiple categories."
        puts "This may potentially result in exact duplicate costs."
        puts "\n"
        table = TTY::Table.new(["Category","Monthly Cost","Yearly Cost"], rows)
        puts table.render(:ascii, alignment: [:center])
        puts "\n"
        @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    end
    
    

end
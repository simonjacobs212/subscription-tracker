module SpendingAnalyzer 
    
    include CliControls

    def spending_summary
        total_cost_per_month
        total_cost_per_year
        most_expensive_service
        cost_by_category
        duplicate_spending
    end

    def display_spending_summary
        system 'clear'
        puts "Spending Summary"
        puts "-----------------------------------"
        puts "Your total daily spending is: #{sprintf('%.2f', @user.spending_per_day.round(2))}"
        puts "-----------------------------------"
        puts "Your total monthly spending is: #{sprintf('%.2f', @user.spending_per_month.round(2))}"
        puts "-----------------------------------"
        puts "Your total yearly spending is: #{sprintf('%.2f', @user.spending_per_year.round(2))}"
        puts "-----------------------------------"
    end

    def display_most_expensive_subscription
        system 'clear'
        puts "Your most expensive subscription is #{@user.most_expensive_service.name}."
        puts "With a cost per day of $#{sprintf('%.2f', @user.most_expensive_service.normalize_cost.round(2))}."
    end

    # def cost_by_category
    #     @user.daily_spending_by_category
    # end


end
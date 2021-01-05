require_all 'app/tools'

module AccessSubscriptions
  include CliControls
  include LoginControl

  def access_subscriptions
    system 'clear'
    subscriptions_action_selection

  end

  def subscriptions_action_selection

  end

  



end
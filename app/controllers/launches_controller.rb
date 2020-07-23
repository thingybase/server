# Launches the user to the right place depending on if they're logged
# in, completely new, or have a few accounts.
class LaunchesController < ApplicationController
  skip_security!

  def show
    if logged_in?
      redirect_to redirect_url
    else
      redirect_to new_session_url
    end
  end

  private
    def redirect_url
      accounts = policy_scope(Account)

      case accounts.count
      when 0
        new_account_url
      when 1
        account_items_url accounts.first
      else
        accounts_url
      end
    end
end
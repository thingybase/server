# Launches the user to the right place depending on if they're logged
# in, completely new, or have a few accounts.
class LaunchesController < ApplicationController
  skip_security!
  before_action :require_login

  def account
    redirect_to account_redirect_url
  end
  alias :show :account

  def profile
    redirect_to profile_redirect_url
  end

  def items
    redirect_to items_redirect_url
  end

  def people
    redirect_to people_redirect_url
  end

  private
    def items_redirect_url
      account_items_url(current_account)
    end

    def people_redirect_url
      account_people_url(current_account)
    end

    def account_redirect_url
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

    def profile_redirect_url
      user_url current_user
    end

    def require_login
      redirect_to new_session_url unless logged_in?
    end

    def current_accounts
      policy_scope(Account)
    end

    def current_account
      current_accounts.first
    end
end

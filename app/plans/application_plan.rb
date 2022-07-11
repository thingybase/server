class ApplicationPlan < Featureomatic::BasePlan
  attr_reader :account, :iap

  def initialize(account:, iap: false)
    @account = account
    @iap = iap
  end

  def pricing
    disabled if iap
  end

  def global_navigation
    disabled if iap
  end

  protected
    def plan(klass)
      klass.new account: account, iap: iap
    end
end

class MemberRequestsController < Resourcefully::ResourcesController
  def self.resource
    MemberRequest
  end

  protected
    def navigation_key
      "People"
    end
end

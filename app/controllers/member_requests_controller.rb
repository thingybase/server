class MemberRequestsController < ResourcesController
  def self.resource
    MemberRequest
  end

  protected
    def navigation_section
      "People"
    end
end

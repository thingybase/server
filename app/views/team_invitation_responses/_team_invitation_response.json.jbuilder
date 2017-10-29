json.extract! team_invitation_response, :id, :user, :team, :created_at, :updated_at
json.url team_invitation_response_url(team_invitation_response, format: :json)

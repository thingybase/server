json.extract! team_invitation, :id, :email, :name, :token, :team_id, :expires_at, :user_id, :created_at, :updated_at
json.url team_invitation_url(team_invitation, format: :json)

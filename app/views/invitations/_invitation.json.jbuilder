json.extract! invitation, :id, :email, :name, :token, :team_id, :user_id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)

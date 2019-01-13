json.extract! invitation_response, :id, :user, :account, :created_at, :updated_at
json.url invitation_response_url(invitation_response, format: :json)

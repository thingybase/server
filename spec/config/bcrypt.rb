# Make BCrypt run faster in test environments.
BCrypt::Engine.cost = 1

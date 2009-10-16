# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_playlist_session',
  :secret      => '6ee8fb45410bb7842c60e7303eddf06d9438d1f1cd7b98d6f719c47cfd7b24f5514cdc49285cf33b56c922b9d4407cd031011e76bd7902c6127b6dde5cf8250d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

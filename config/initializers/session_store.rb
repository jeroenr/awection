# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_skeleton_session',
  :secret      => 'cf3042839268581c03e7162e7427030640d6c8ee19570bfefdd68c66c726a65dd5f5d9e6f5dac8811dd8cdfd7a3b528ad670ca9321242056a965405d1d779da0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

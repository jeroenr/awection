# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_invoice_session',
  :secret      => 'e0709188a38a8f85656aff6a06b73aebfcac92dd7fb972fcfa82c402e88742f096f94b5b837fe5b3090bec66e6ade64ef5ec8dbd6b44e8910b1926d8ccd47196'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

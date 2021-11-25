Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
# Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

# Setup Stripe API keys
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

# Set your publishable key: 
Stripe.api_key = Rails.application.credentials.dig(:stripe, :publishable_key)


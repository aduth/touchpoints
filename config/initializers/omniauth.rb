# LOGIN_GOV_PRIVATE_KEY expects the .pem in a certain format
# For the .pem (private key):
#
# pem_string = File.open("your-filepath.pem", "r").read
# use the value `pem_string`

# eg:
# export LOGIN_GOV_PRIVATE_KEY="#{pem_string}"
# Of note: .gsub() is used for the `private_key`
# below, to decode the line breaks properly

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :login_dot_gov, {
    name: :login_dot_gov,
    client_id: ENV.fetch("LOGIN_GOV_CLIENT_ID"),
    idp_base_url: ENV.fetch("LOGIN_GOV_IDP_BASE_URL"),
    ial: 1,
    private_key: OpenSSL::PKey::RSA.new(ENV.fetch("LOGIN_GOV_PRIVATE_KEY").gsub("\\n", "\n")),
    redirect_uri: ENV.fetch("LOGIN_GOV_REDIRECT_URI")
  }
end
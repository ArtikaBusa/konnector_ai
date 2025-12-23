module ApiAuthHelper
  def auth_headers(user)
    {
      "Authorization" => "Bearer #{user.authentication_token}",
      "Content-Type" => "application/json"
    }
  end
end

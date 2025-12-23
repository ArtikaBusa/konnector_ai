module ApiHeaders
  def json_headers(user = nil)
    headers = {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    if user
      headers["Authorization"] = "Bearer #{user.authentication_token}"
    end

    headers
  end
end

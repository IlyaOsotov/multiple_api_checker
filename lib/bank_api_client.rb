class BankApiClient
  protected

  def login(path, login, password)
    conn = Faraday.new(path)

    resp = conn.get do |req|
      req.url '/login', login: login, password: password
    end

    raise '401 unauthorized' if resp.status == 401
  end
end

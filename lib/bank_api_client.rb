require 'faraday'
require 'json'

class BankApiClient
  protected

  def login(path, login, password)
    conn = Faraday.new(path)

    resp = conn.get do |req|
      req.url '/login', login: login, password: password
    end

    raise '401 unauthorized' if resp.status == 401

    resp.body
  end

  def call_service(path, params, token)
    conn = Faraday.new(path)

    resp = conn.post do |req|
      req.body = params
      req.headers['Auth-Token'] = token
      req.headers['Content-Type'] = 'application/json'
    end

    resp.body
  end
end

require 'faraday'

class SecondBankApiClient
  def call(_service, params, _headers)
    conn = Faraday.new('http://bank_api_first.com/')

    resp = conn.get do |req|
      req.url '/login', login: params['login'], password: params['password']
    end

    return '401' if resp.status == 401
  end
end

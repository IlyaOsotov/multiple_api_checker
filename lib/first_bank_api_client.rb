require 'faraday'

class FirstBankApiClient
  def call(service, params, headers)
    conn = Faraday.new('http://bank_api_first.com/')

    resp = conn.get do |req|
      req.url '/login', login: params['login'], password: params['password']
    end

    return '401' if resp.status == 401
  end
end

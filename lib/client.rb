require 'multiple_api_checker/version'

class Client
  REGISTERED_APIS = %i[bank_api_first bank_api_second].freeze
  REGISTERED_SERVICES = %i[movement_list].freeze

  def initialize(bank_api)
    @bank_api = bank_api(bank_api)
  end

  def call(service, _params = {}, _headers = {})
    raise "not registered service #{service}" unless REGISTERED_SERVICES.include? service
  end

  private

  def bank_api(bank_api)
    raise "not registered api #{bank_api}" unless REGISTERED_APIS.include? bank_api.to_sym
  end
end

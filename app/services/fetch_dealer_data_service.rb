require 'faraday'

class FetchDealerDataService
  FAKER_API_ENDPOINT = 'https://fakerapi.it/api/v1/companies?_seed=1&_quantity=200'.freeze

  def self.call
    Faraday.get(FAKER_API_ENDPOINT)
  rescue Faraday::ConnectionFailed
    nil
  end
end

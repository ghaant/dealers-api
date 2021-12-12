class DealersController < ApplicationController
  def sync_data
    response = FetchDealerDataService.call

    SyncDealerDataService.new(response).call if response&.status == 200
  end
end

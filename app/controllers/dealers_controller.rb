class DealersController < ApplicationController
  def sync_data
    response = FetchDealerDataService.call

    if response&.status == 200 && SyncDealerDataService.new(response).call
      render json: 'The dealer data has been successfully synced.', status: 200
    end
  end
end

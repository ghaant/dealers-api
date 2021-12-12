class DealersController < ApplicationController
  def sync_data
    response = FetchDealerDataService.call

    if response&.status == 200 && SyncDealerDataService.new(response).call
      render json: 'The dealer data has been successfully synced.', status: 200
    end
  end

  def index
    dealers = FindDealersService.new(search_params).call

    render json: format_dealers_output(dealers)
  end

  private

  def search_params
    {
      name: params[:name],
      phone: params[:phone],
      street: params[:street],
      city: params[:city],
      zipcode: params[:zipcode],
      country: params[:country]
    }
  end

  def format_dealers_output(dealers)
    dealers.select('
      dealers.id,
      dealers.name,
      dealers.phone,
      addresses.street,
      addresses.city,
      addresses.zipcode,
      addresses.country,
      addresses.latitude,
      addresses.longitude
      ')
  end
end

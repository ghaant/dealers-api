class FindDealersService
  def initialize(search_params)
    @name = search_params[:name]&.downcase
    @phone = search_params[:phone]
    @street = search_params[:street]&.downcase
    @city = search_params[:city]
    @zipcode = search_params[:zipcode]
    @country = search_params[:country]
  end

  def call
    Dealer.joins(:addresses).merge(Address.current_addresses).
      where(
        "
          LOWER(dealers.name) LIKE ?
          AND CAST(dealers.phone AS VARCHAR) LIKE ?
          AND LOWER(addresses.street) LIKE ?
          AND LOWER(addresses.city) = LOWER(COALESCE(?, addresses.city))
          AND LOWER(addresses.zipcode) = LOWER(COALESCE(?, addresses.zipcode))
          AND LOWER(addresses.country) = LOWER(COALESCE(?, addresses.country))
        ",
        "%#{@name}%", "%#{@phone}%", "%#{@street}%", @city, @zipcode, @country
      )
  end
end

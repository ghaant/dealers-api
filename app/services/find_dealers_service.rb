class FindDealersService
  def initialize(search_params)
    @name = search_params[:name]
    @phone = search_params[:phone]
    @street = search_params[:street]
    @city = search_params[:city]
    @zipcode = search_params[:zipcode]
    @country = search_params[:country]
  end

  def call
    Dealer.joins(:addresses).merge(Address.current_addresses).
      where(
        "
          dealers.name LIKE ?
          AND CAST(dealers.phone AS VARCHAR) LIKE ?
          AND addresses.street LIKE ?
          AND addresses.city = COALESCE(?, addresses.city)
          AND addresses.zipcode = COALESCE(?, addresses.zipcode)
          AND addresses.country = COALESCE(?, addresses.country)
        ",
        "%#{@name}%", "%#{@phone}%", "%#{@street}%", @city, @zipcode, @country
      )
  end
end

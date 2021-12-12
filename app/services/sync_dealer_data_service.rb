class SyncDealerDataService
  def initialize(raw_data)
    @parsed_data = JSON.parse(raw_data.body)['data']
  end

  def call
    # We presume company names are unique and can't be changed,
    # otherwise it would be impossible ot identify a company.
    delete_non_actual_dealers

    @parsed_data.each do |dealer_hash|
      dealer = Dealer.find_by(name: dealer_hash['name'])
      int_phone = dealer_hash['phone']&.delete_prefix('+')&.to_i

      if dealer.blank?
        next if int_phone.blank?

        create_dealer(dealer_hash['name'], int_phone, dealer_hash['addresses'])
      else
        delete_non_actual_addresses(dealer.addresses, dealer_hash['addresses'])

        update_dealer(dealer, int_phone, dealer_hash['addresses'])
      end
    end
  end

  private

  def delete_non_actual_dealers
    actual_nameset = @parsed_data.map { |dealer_hash| dealer_hash['name'] }
    Dealer.where.not(name: actual_nameset).destroy_all
  end

  def delete_non_actual_addresses(addresses, actual_addresses)
    addresses.find_each do |address|
      to_be_removed = actual_addresses.none? do |address_hash|
        address_hash['street'] == address.street &&
          address_hash['city'] == address.city &&
          address_hash['zipcode'] == address.zipcode &&
          address_hash['country'] == address.country
      end

      address.destroy if to_be_removed
    end
  end

  def create_dealer(name, phone, addresses)
    dealer = Dealer.new(name: name, phone: phone)
    return unless dealer.save

    addresses.each { |address_hash| create_address(dealer, address_hash) }
  end

  def update_dealer(dealer, phone, addresses)
    dealer.update(phone: phone) if dealer.phone != phone

    addresses.each do |address_hash|
      next if dealer.addresses.exists?(
        street: address_hash['street'],
        city: address_hash['city'],
        zipcode: address_hash['zipcode'],
        country: address_hash['country']
      )

      create_address(dealer, address_hash)
    end
  end

  def create_address(dealer, address)
    # Other attributes will be checked by the model validations.
    return if address['latitude'].blank? || address['longitude'].blank?

    dealer.addresses.create(
      street: address['street'],
      city: address['city'],
      zipcode: address['zipcode'],
      country: address['country'],
      latitude: address['latitude'].to_f,
      longitude: address['longitude'].to_f
    )
  end
end

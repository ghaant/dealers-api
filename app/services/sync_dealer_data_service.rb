class SyncDealerDataService
  def initialize(raw_data)
    @parsed_data = JSON.parse(raw_data.body)['data']
  end

  def call
    # We presume company names are unique and can't be changed,
    # otherwise it would be impossible ot identify a company.
    @parsed_data.each do |dealer_hash|
      dealer = Dealer.find_by(name: dealer_hash['name'])
      int_phone = dealer_hash['phone']&.delete_prefix('+')&.to_i

      if dealer.blank? && int_phone.present?
        dealer = Dealer.new(name: dealer_hash['name'], phone: int_phone)
        next unless dealer.save

        dealer_hash['addresses'].each do |address_hash|
          # Other attributes will be checked by the model validations.
          next unless address_hash['latitude'].present? && address_hash['longitude'].present?

          dealer.addresses.create(
            street: address_hash['street'],
            city: address_hash['city'],
            zipcode: address_hash['zipcode'],
            country: address_hash['country'],
            latitude: address_hash['latitude'].to_f,
            longitude: address_hash['longitude'].to_f
          )
        end
      else
        dealer.update(phone: int_phone) if dealer.phone != int_phone

        dealer_hash['addresses'].each do |address_hash|
          next if address_hash['latitude'].blank? || address_hash['longitude'].blank? ||
                  dealer.addresses.exists(
                    street: address_hash['street'],
                    city: address_hash['city'],
                    zipcode: address_hash['zipcode'],
                    country: address_hash['country']
                  )

          dealer.addresses.create(
            street: address_hash['street'],
            city: address_hash['city'],
            zipcode: address_hash['zipcode'],
            country: address_hash['country'],
            latitude: address_hash['latitude'].to_f,
            longitude: address_hash['longitude'].to_f
          )
        end
      end
    end

    
  end
end
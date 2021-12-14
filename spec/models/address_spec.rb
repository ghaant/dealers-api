require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validations' do
    let!(:dealer) { Dealer.create(name: 'qwe', phone: 123) }

    describe 'street' do
      context 'when street is missing' do
        specify do
          address = dealer.addresses.new(
            street: nil,
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:street]).to eq(["can't be blank"])
        end
      end

      context 'when street is present' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(true)
          expect(address.errors.messages[:street]).to eq([])
        end
      end
    end

    describe 'city' do
      context 'when city is missing' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: nil,
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:city]).to eq(["can't be blank"])
        end
      end

      context 'when city is present' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(true)
          expect(address.errors.messages[:city]).to eq([])
        end
      end
    end

    describe 'zipcode' do
      context 'when zipcode is missing' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: nil,
            zipcode: nil,
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:zipcode]).to eq(["can't be blank"])
        end
      end

      context 'when zipcode is present' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(true)
          expect(address.errors.messages[:zipcode]).to eq([])
        end
      end
    end

    describe 'country' do
      context 'when country is missing' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: nil,
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:country]).to eq(["can't be blank"])
        end
      end

      context 'when country is present' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: 123.456
          )

          expect(address.valid?).to be(true)
          expect(address.errors.messages[:country]).to eq([])
        end
      end
    end

    describe 'latitude' do
      context 'when latitude is missing' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: nil,
            longitude: 123.456
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:latitude]).to eq(['is not a number'])
        end
      end

      context 'when latitude is present' do
        context 'and not a number' do
          specify do
            address = dealer.addresses.new(
              street: 'Blahblah strasse 3',
              city: 'Berlin',
              zipcode: '12345',
              country: 'Germany',
              latitude: 'asd',
              longitude: 123.456
            )

            expect(address.valid?).to be(false)
            expect(address.errors.messages[:latitude]).to eq(['is not a number'])
          end
        end

        context 'and a number' do
          specify do
            address = dealer.addresses.new(
              street: 'Blahblah strasse 3',
              city: 'Berlin',
              zipcode: '12345',
              country: 'Germany',
              latitude: 123.456,
              longitude: 123.456
            )

            expect(address.valid?).to be(true)
            expect(address.errors.messages[:latitude]).to eq([])
          end
        end
      end
    end

    describe 'longitude' do
      context 'when longitude is missing' do
        specify do
          address = dealer.addresses.new(
            street: 'Blahblah strasse 3',
            city: 'Berlin',
            zipcode: '12345',
            country: 'Germany',
            latitude: 123.456,
            longitude: nil
          )

          expect(address.valid?).to be(false)
          expect(address.errors.messages[:longitude]).to eq(['is not a number'])
        end
      end

      context 'when longitude is present' do
        context 'and not a number' do
          specify do
            address = dealer.addresses.new(
              street: 'Blahblah strasse 3',
              city: 'Berlin',
              zipcode: '12345',
              country: 'Germany',
              latitude: 123.456,
              longitude: 'qwer'
            )

            expect(address.valid?).to be(false)
            expect(address.errors.messages[:longitude]).to eq(['is not a number'])
          end
        end

        context 'and a number' do
          specify do
            address = dealer.addresses.new(
              street: 'Blahblah strasse 3',
              city: 'Berlin',
              zipcode: '12345',
              country: 'Germany',
              latitude: 123.456,
              longitude: 123.456
            )

            expect(address.valid?).to be(true)
            expect(address.errors.messages[:longitude]).to eq([])
          end
        end
      end
    end
  end
end

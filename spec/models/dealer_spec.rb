require 'rails_helper'

RSpec.describe Dealer, type: :model do
  describe 'Validations' do
    describe 'name' do
      context 'when name is missing' do
        specify do
          dealer = Dealer.new(name: nil, phone: 123)

          expect(dealer.valid?).to be(false)
          expect(dealer.errors.messages[:name]).to eq(["can't be blank"])
        end
      end

      context 'when name is present' do
        context 'and not unique' do
          before { Dealer.create(name: 'qwe', phone: 123) }

          specify do
            dealer = Dealer.new(name: 'qwe', phone: 456)

            expect(dealer.valid?).to be(false)
            expect(dealer.errors.messages[:name]).to eq(['has already been taken'])
          end
        end

        context 'and unique' do
          specify do
            dealer = Dealer.new(name: 'qwe', phone: 456)

            expect(dealer.valid?).to be(true)
            expect(dealer.errors.messages[:name]).to eq([])
          end
        end
      end
    end

    describe 'phone' do
      context 'phone is missing' do
        specify do
          dealer = Dealer.new(name: 'qwe', phone: nil)

          expect(dealer.valid?).to be(false)
          expect(dealer.errors.messages[:phone]).to eq(['is not a number'])
        end
      end

      context 'phone is present' do
        context 'and not numerical' do
          specify do
            dealer = Dealer.new(name: 'qwe', phone: 'asd')

            expect(dealer.valid?).to be(false)
            expect(dealer.errors.messages[:phone]).to eq(['is not a number'])
          end
        end

        context 'and numerical' do
          context 'and not integer' do
            specify do
              dealer = Dealer.new(name: 'qwe', phone: 123.456)

              expect(dealer.valid?).to be(false)
              expect(dealer.errors.messages[:phone]).to eq(['must be an integer'])
            end
          end

          context 'and integer' do
            specify do
              dealer = Dealer.new(name: 'qwe', phone: 123)

              expect(dealer.valid?).to be(true)
              expect(dealer.errors.messages[:phone]).to eq([])
            end
          end
        end
      end
    end
  end
end

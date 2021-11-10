require 'rails_helper'

describe 'Property reservation can be cancelled' do
    it 'successfully' do
# arrange
        user = create :user
        property_reservation = create(:property_reservation, user: user)

# act
        login_as user, scope: user
        visit property_reservation_path
        click_on 'cancel_reservation_id'

# assert
        expect(page).to have_content('Reserva cancelada')
        expect(property_reservation.cancelled?).to be(true)
    end 
end
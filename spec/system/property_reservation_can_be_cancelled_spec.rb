require 'rails_helper'

describe 'Property reservation can be cancelled' do
  it 'successfully' do
    # arrange
    user = create :user
    property_reservation = create(:property_reservation, user: user)

    # act
    login_as user, scope: user
    visit property_reservation_path(property_reservation)
    click_on 'cancel_reservation'

    # assert
    expect(page).to have_content('Reserva cancelada')
    expect(property_reservation.reload.canceled?).to be(true)
  end

  context 'unless user is the owner' do
    it 'cannot be cancelled by property owner' do
      property_reservation = create(:property_reservation)

      login_as property_reservation.property.property_owner, scope: :property_owner
      visit property_reservation_path(property_reservation)

      expect(page).not_to have_css('a#cancel_reservation')
    end
  end
end

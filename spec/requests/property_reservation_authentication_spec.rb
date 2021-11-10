require 'rails_helper'

describe 'Property reservation' do
  it 'cannot be cancelled by visitor' do
    property_reservation = create(:property_reservation)

    post "/property_reservations/#{property_reservation.id}/cancel"

    expect(property_reservation.reload.canceled?).to be false
    expect(response).to redirect_to(new_user_session_path)
    end

  it 'cannot be cancelled by owner' do
    property_reservation = create(:property_reservation)
    login_as property_reservation.property.property_owner, scope: :property_owner

    post "/property_reservations/#{property_reservation.id}/cancel"

    expect(property_reservation.reload.canceled?).to be false
    expect(response).to redirect_to(new_user_session_path)
  end
end
class PassengerMailer < ApplicationMailer
  def booking_email
    @booking = params[:booking]

    @booking.passengers.each do |passenger|
      mail(subject: 'Airlines Booking Confirmation', to: passenger.email)
    end
  end
end

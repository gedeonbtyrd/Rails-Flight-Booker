require 'rails_helper'

RSpec.describe 'Searching for a flight', type: :feature do
  let!(:ormoc) { FactoryBot.create(:airport, code: 'OMC', city: 'Ormoc') }
  let!(:manila) { FactoryBot.create(:airport, code: 'MLA', city: 'Manila') }
  let(:tomorrow) { (Date.today + 1).strftime("%Y-%m-%d") }
  let(:today) { Date.today.strftime("%Y-%m-%d") }
  let!(:tomorrows_flight) { FactoryBot.create(:flight, departure_airport: ormoc,
                                                arrival_airport: manila,
                                                departure_time: Faker::Time.between(from: tomorrow, to: tomorrow),
                                                departure_date: tomorrow
                                               )
                           }
  let!(:todays_flight) { FactoryBot.create(:flight, departure_airport: ormoc,
                                            arrival_airport: manila,
                                            departure_time: Faker::Time.between(from: today, to: today),
                                            departure_date: today
                                           )
                       }

  context 'when 2 flights available' do
    before do
      visit root_path
      select 'Ormoc', from: 'departure_airport_id'
      select 'Manila', from: 'arrival_airport_id'
      select '2', from: 'passengers'
      select tomorrow, from: 'departure_date'
      click_on 'Search'
    end

    it 'finds 2 available flights' do
      expect(page).to have_content('2 flights available')
    end
  end

  context 'when 1 flight available' do
    before do
      visit root_path
      select 'Ormoc', from: 'departure_airport_id'
      select 'Manila', from: 'arrival_airport_id'
      select '2', from: 'passengers'
      select today, from: 'departure_date'
      click_on 'Search'
    end

    it 'finds 1 available flight' do
      expect(page).to have_content('1 flight available')
    end
  end

  context 'when booking a flight' do
    before do
      visit root_path
      select 'Ormoc', from: 'departure_airport_id'
      select 'Manila', from: 'arrival_airport_id'
      select '2', from: 'passengers'
      select tomorrow, from: 'departure_date'
      click_on 'Search'
      choose("flight_id_#{tomorrows_flight.id}")
      click_on 'Book'
    end

    it 'has 2 passenger creation forms' do
      expect(page).to have_content 'Passenger 2 Info'
    end

    it 'does not have more than 2 passenger creation forms' do
      expect(page).not_to have_content 'Passenger 3 Info'
    end

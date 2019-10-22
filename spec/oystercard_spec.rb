require 'oystercard'

describe Oystercard do
  let(:station){ double :station }
  let(:station2){ double :station }
  let(:station3){ double :station }
  let(:station4){ double :station }
  context 'Card balance' do
    it 'has a zero balance when created' do
      expect(subject.balance).to eq 0.00
    end

    it 'User can add value to card' do
      expect(subject.balance).to eq 0.00
      subject.add_value(20.00)
      expect(subject.balance).to eq 20.00
    end
    it 'User cannot add more than max balance' do
      subject.add_value(10)
      expect{ subject.add_value(90) }.to raise_error "Sorry you tried to add £90.00 the maximum you can add to this card currently is £80.00"
    end

    it 'Has a default max balance' do
      expect(Oystercard::DEFAULT_MAX_BALANCE).to eq 90
    end
  end

  context 'Journey flag' do


    it 'Does not allow travel without minimum balance requirement' do
      expect{ subject.touch_in(station) }.to raise_error "Balance too low"
    end

    it 'Sets journey flag when touched in' do
      subject.add_value(1)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'User can touch out' do
      subject.add_value(1)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject).to_not be_in_journey
    end

    it 'Deducts balance by £1 when touched out' do
      expect{ subject.touch_out(station2) }.to change{ subject.balance }.by(-1.00)
    end


  end

  context 'Station name' do

    it 'Has a default value of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'Remembers which station it started at' do
      subject.add_value(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end

  context 'Journey' do

    it 'Is empty as default' do
      expect(subject.journeys).to eq []
    end

    it 'Records entry and exit station' do
      subject.add_value(5)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.journeys).to include(entry: station, exit: station2)
    end

  end





end

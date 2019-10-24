require 'journey'

describe Journey do

  it "Knows whether it's in a journey or not" do
    expect(subject).to_not be_in_journey
  end
end

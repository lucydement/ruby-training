require_relative '../lib/population'

RSpec.describe Population do
  let(:population) {Population.new}

  it "should generate a non negative number of people buying lemonade" do
    expect(population).to receive(:rand).with(-5..5).and_return(-5)

    expect(population.number_of_people_walking_by(temp: -10)).to eql 0
  end

  it "should be a whole number" do
    expect(population).to receive(:rand).with(-5..5).and_return(0)

    expect(population.number_of_people_walking_by(temp: 11)).to be_a(Integer)
  end
end
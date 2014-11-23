require_relative 'people_buying'

RSpec.describe PeopleBuying do
  let(:people_buying) {PeopleBuying.new}

  it "returns the people buying given a price and people walking by" do
    expect(people_buying.calculate(4,3)).to eql 1
  end
end
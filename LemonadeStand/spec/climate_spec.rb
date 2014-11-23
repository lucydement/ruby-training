require_relative '../lib/climate'

RSpec.describe Climate do
  context "When it is close to the maximum" do
    let(:climate) {Climate.new(previous_temp: 40)}

    it "generates a new temperature below max" do
      expect(climate).to receive(:rand).with(35..45).and_return(41)

      expect(climate.generate_temp).to eq 40
    end
  end

  context "When it is close to the minimum" do
    let(:climate) {Climate.new(previous_temp: -10)}

    it "generates a new temperature above the min" do
      expect(climate).to receive(:rand).with(-15..-5).and_return(-12)

      expect(climate.generate_temp).to eq -10
    end
  end

  let(:climate) {Climate.new(previous_temp: 21)}

  it "generates a new temperature 5 either side of the old" do
    expect(climate).to receive(:rand).with(16..26).and_return(17)

    expect(climate.generate_temp).to eq 17
  end
end
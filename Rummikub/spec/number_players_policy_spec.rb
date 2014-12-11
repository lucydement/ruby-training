require 'rails_helper'

RSpec.describe NumberPlayersPolicy do
  context "When given a correct value" do
    it "returns true" do
      number_players_policy = NumberPlayersPolicy.new(3)

      expect(number_players_policy.call).to eql true
    end
  end

  context "When given a string" do
    it "returns false" do
      number_players_policy = NumberPlayersPolicy.new("3")

      expect(number_players_policy.call).to eql false
    end
  end

  context "When given a number too low" do
    it "return false" do
      number_players_policy = NumberPlayersPolicy.new(1)

      expect(number_players_policy.call).to eql false
    end
  end

  context "When given a number too high" do
    it "return false" do
      number_players_policy = NumberPlayersPolicy.new(10)

      expect(number_players_policy.call).to eql false
    end
  end
end
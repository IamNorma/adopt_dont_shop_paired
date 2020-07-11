require 'rails_helper'

RSpec.describe Favorites do
  subject { Favorites.new(["1", "2"]) }

  describe '#count' do
    it "calculates the total number of pets that have been favorited" do
      expect(subject.count).to eq(2)
    end
  end

  describe '#add_pet' do
    it "adds a pet to its contents" do
      subject.add_pet("3")
      subject.add_pet("4")

      expect(subject.contents).to eq(["1", "2", "3", "4"])
    end
  end
end

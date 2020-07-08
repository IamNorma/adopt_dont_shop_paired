require 'rails_helper'

RSpec.describe Favorite do
  describe 'relationships' do
    it { should have_many :favorite_pets }
    it { should have_many(:pets).through(:favorite_pets) }
  end
end

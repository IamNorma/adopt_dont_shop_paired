require 'rails_helper'

RSpec.describe FavoritePet do
  describe 'relationships' do
    it { should belong_to :favorite }
    it { should belong_to :pet }
  end
end

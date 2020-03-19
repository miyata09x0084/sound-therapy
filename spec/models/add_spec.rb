require 'rails_helper'

RSpec.describe Add, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with url' do
        expect(build(:add, artist: nil, song: nil)).to be_valid
      end

      it 'is valid with url and artist and song' do
        expect(build(:add)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without name ' do
        add = build(:add, url: nil)
        add.valid?
        expect(add.errors[:url]).to include("can't be blank")
      end

      it 'is invalid without url and artist and song' do
        add = build(:add, url: nil, artist: nil, song: nil)
        add.valid?
        expect(add.errors[:url]).to include("can't be blank")
      end

      # it 'is invaid without user_id' do
      #   add = build(:add, user_id: nil)
      #   add.valid?
      #   expect(add.errors[:user]).to include("must exist")
      # end
    end
  end
end
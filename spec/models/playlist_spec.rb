require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe '#create' do

    context 'can save' do
      it 'is valid with name' do
        expect(build(:playlist)).to be_valid
      end

      it 'is valid with image' do
        expect(build(:playlist, image:  nil)).to be_valid
      end

      it 'is valid with name and image' do
        expect(build(:playlist)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without name ' do
        playlist = build(:playlist, name: nil)
        playlist.valid?
        expect(playlist.errors[:name]).to include("can't be blank")
      end

      it 'is invalid without name and image' do
        playlist = build(:playlist, name: nil, image: nil)
        playlist.valid?
        expect(playlist.errors[:name]).to include("can't be blank")
      end

      # it 'is invaid without user_id' do
      #   playlist = build(:playlist, user_id: nil)
      #   playlist.valid?
      #   expect(playlist.errors[:user]).to include("must exist")
      # end
    end
  end
end
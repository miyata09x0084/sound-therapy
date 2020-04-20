require 'rails_helper'

describe PlaylistsController do
  let(:user) { create(:user) }

  describe '#index' do

    context 'log in' do
      before do
        login user
        get :index
      end

      it "populates an array of playlists ordered by created_at DESC" do
        playlists = create_list(:playlist, 3)
        get :index
        expect(assigns(:playlists)).to match(playlists.sort{|a, b| b.created_at <=> a.created_at })
      end

      it 'redners index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index
      end

      # it 'redirects to new_user_session_path' do
      #   expect(response).to redirect_to(new_user_session_path)
      # end
    end
  end

  describe '#create' do
    let(:params) { { user_id: user.id, playlist: attributes_for(:playlist) } }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up playlist' do
          expect{ subject }.to change(Playlist, :count).by(1)
        end

        it 'redirects to playlist_adds_path' do
          subject
          # expect(response).to redirect_to(playlist_adds_path(playlist))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { user_id: user.id, playlist: attributes_for(:playlist, name: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Playlist, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :new
        end
      end
    end

    context 'not log in' do
      before do
        get :index
      end

      # it 'redirects to new_user_session_path' do
      #   post :create, params: params
      #   expect(response).to redirect_to(new_user_session_path)
      # end
    end
  end
end


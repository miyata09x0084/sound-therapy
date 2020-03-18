require 'rails_helper'

describe AddsController do
  let(:playlist) { create(:playlist) }
  let(:user) { create(:user) }

  describe '#index' do
    context 'log in' do
      before do
        login user
        get :index, params: { playlist_id: playlist.id }
      end

      it 'assigns @add' do
        expect(assigns(:add)).to be_a_new(Add)
      end

      it 'assigns @playlist' do
        expect(assigns(:playlist)).to eq playlist
      end

      it 'redners index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: { playlist_id: playlist.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { playlist_id: playlist.id, user_id: user.id, add: attributes_for(:add) } }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up add' do
          expect{ subject }.to change(Add, :count).by(1)
        end

        it 'redirects to playlist_adds_path' do
          subject
          expect(response).to redirect_to(playlist_adds_path(playlist))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { playlist_id: playlist.id, user_id: user.id, add: attributes_for(:add, url: nil, artist: nil, song: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Add, :count)
        end

        it 'renders index' do
          subject
          expect(response).to redirect_to(playlist_adds_path(playlist))
        end
      end
    end

    context 'not log in' do
      before do
        get :create, params: params
      end

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
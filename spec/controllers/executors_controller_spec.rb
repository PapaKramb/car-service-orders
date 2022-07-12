require 'rails_helper'

RSpec.describe ExecutorsController, type: :controller do
  let(:service) { create(:service) }
  let(:executor) { create(:executor, service: service) }

  describe 'GET #index' do
    let(:executors) { create_list(:executor, 3, service: service) }

    before { get :index }

    it 'popilates an array of all executors' do
      expect(assigns(:executors)).to match_array(executors)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: executor } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: executor } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do  
    context 'with valid attributes' do
      it 'saves a new executor in the database' do
        expect { post :create, params: { executor: attributes_for(:executor, service_id: service.id) } }.to change(Executor, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { executor: attributes_for(:executor) }
        expect(response).to be_ok
      end
    end

    context 'with invalid attributes' do
      it 'does not save the executor' do
        expect { post :create, params: { executor: attributes_for(:executor, :invalid) } }.to_not change(Executor, :count)
      end

      it 're-renders new view' do
        post :create, params: { executor: attributes_for(:executor, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested executor' do
        patch :update, params: { id: executor, executor: attributes_for(:executor) }
        expect(assigns(:executor)).to eq executor
      end

      it 'change executor attributes' do
        patch :update, params: { id: executor, executor: { name: 'new name' } }
        executor.reload

        expect(executor.name).to eq 'new name'
      end

      it 'redirect to updated executor' do
        patch :update, params: { id: executor, executor: attributes_for(:executor) }
        expect(response).to redirect_to executor
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: executor, executor: attributes_for(:executor, :invalid) } }
      it 'does not change executor' do
        executor.reload

        expect(executor.name).to eq executor.name
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:service) { create(:service) }
    let!(:executor) { create(:executor, service: service) }

    it 'deletes the executor' do
      expect { delete :destroy, params: { id: executor } }.to change(Executor, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: executor }
      expect(response).to redirect_to executors_path
    end
  end
end

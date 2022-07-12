require 'rails_helper'

RSpec.describe ServicesController, type: :controller do

  let(:service) { create(:service) }

  describe 'GET #index' do
    let(:services) { create_list(:service, 3) }

    before { get :index }

    it 'popilates an array of all services' do
      expect(assigns(:services)).to match_array(services)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: service } }

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
    before { get :edit, params: { id: service } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do  
    context 'with valid attributes' do
      it 'saves a new service in the database' do
        expect { post :create, params: { service: attributes_for(:service) } }.to change(Service, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { service: attributes_for(:service) }
        expect(response).to redirect_to assigns(:service)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the service' do
        expect { post :create, params: { service: attributes_for(:service, :invalid) } }.to_not change(Service, :count)
      end

      it 're-renders new view' do
        post :create, params: { service: attributes_for(:service, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested service' do
        patch :update, params: { id: service, service: attributes_for(:service) }
        expect(assigns(:service)).to eq service
      end

      it 'change service attributes' do
        patch :update, params: { id: service, service: { service_name: 'new service_name' } }
        service.reload

        expect(service.service_name).to eq 'new service_name'
      end

      it 'redirect to updated service' do
        patch :update, params: { id: service, service: attributes_for(:service) }
        expect(response).to redirect_to service
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: service, service: attributes_for(:service, :invalid) } }
      it 'does not change service' do
        service.reload

        expect(service.service_name).to eq service.service_name
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:service) { create(:service) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: service } }.to change(Service, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: service }
      expect(response).to redirect_to services_path
    end
  end
end

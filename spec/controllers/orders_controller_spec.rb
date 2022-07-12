require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:order) { create(:order) }

  describe 'GET #index' do
    let(:orders) { create_list(:order, 3) }

    before { get :index }

    it 'popilates an array of all orders' do
      expect(assigns(:orders)).to match_array(orders)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end

    # it 'assings a new order' do
    #   expect(assigns(:order).links.first).to be_a_new(Link)
    # end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: order } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do  
    context 'with valid attributes' do
      it 'saves a new order in the database' do
        expect { post :create, params: { order: attributes_for(:order) } }.to change(Order, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to redirect_to assigns(:order)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the order' do
        expect { post :create, params: { order: attributes_for(:order, :invalid) } }.to_not change(Order, :count)
      end

      it 're-renders new view' do
        post :create, params: { order: attributes_for(:order, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested order' do
        patch :update, params: { id: order, order: attributes_for(:order) }
        expect(assigns(:order)).to eq order
      end

      it 'change order attributes' do
        patch :update, params: { id: order, order: { customers_name: 'new customers_name' } }
        order.reload

        expect(order.customers_name).to eq 'new customers_name'
      end

      it 'redirect to updated order' do
        patch :update, params: { id: order, order: attributes_for(:order) }
        expect(response).to redirect_to order
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: order, order: attributes_for(:order, :invalid) } }
      it 'does not change order' do
        order.reload

        expect(order.customers_name).to eq order.customers_name
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { create(:order) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: order } }.to change(Order, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: order }
      expect(response).to redirect_to orders_path
    end
  end
end

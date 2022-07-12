require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:service) { create(:service) }
  let(:category) { create(:category, service: service) }

  describe 'GET #index' do
    let(:categories) { create_list(:category, 3, service: service) }

    before { get :index }

    it 'popilates an array of all categorys' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: category } }

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
    before { get :edit, params: { id: category } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested category' do
        patch :update, params: { id: category, category: attributes_for(:category) }
        expect(assigns(:category)).to eq category
      end

      it 'change category attributes' do
        patch :update, params: { id: category, category: { category_name: 'new category_name' } }
        category.reload

        expect(category.category_name).to eq 'new category_name'
      end

      it 'redirect to updated category' do
        patch :update, params: { id: category, category: attributes_for(:category) }
        expect(response).to redirect_to category
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: category, category: attributes_for(:category, :invalid) } }
      it 'does not change category' do
        category.reload

        expect(category.category_name).to eq category.category_name
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create' do  
    context 'with valid attributes' do
      it 'saves a new executor in the database' do
        expect { post :create, params: { category: attributes_for(:category, service_id: service.id) } }.to change(Category, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to be_ok
      end
    end

    context 'with invalid attributes' do
      it 'does not save the category' do
        expect { post :create, params: { category: attributes_for(:category, :invalid) } }.to_not change(Category, :count)
      end

      it 're-renders new view' do
        post :create, params: { category: attributes_for(:category, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:service) { create(:service) }
    let!(:category) { create(:category, service: service) }

    it 'deletes the category' do
      expect { delete :destroy, params: { id: category } }.to change(Category, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: category }
      expect(response).to redirect_to categories_path
    end
  end
end

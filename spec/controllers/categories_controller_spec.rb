# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  login_user
  before do
    @category = create(:category)
    @sub_category = create(:category, primarycategory_id: @category.id)
  end

  describe "POST#create" do
    it "create category - not authorized user login" do
      get :new
      expect(response).to redirect_to dashboard_index_url
      expect(flash[:alert]).to eq(I18n.t('user_not_authorized'))
    end
  end

  describe "GET#index" do
    it "returns list of categories" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET#show" do
    it "returns a category" do
      params = {id: @category.id}
      get :show, params: params
      expect(response).to have_http_status(200)
    end

    it "returns error for invalid category id" do
      params = {id: "invalid_id"}
      get :show, params: params
      expect(response).to redirect_to categories_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "POST#create" do
    login_admin
    it "admin creates a new category" do
      post :create, params: { category: attributes_for(:category) }
      expect(response).to redirect_to categories_path
      expect(flash[:notice]).to be_present
    end

    it "returns error for insufficient category params" do
      post :create, params: { category: {id: @category.id} }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end
  end

  describe "GET#edit" do
    login_admin
    it "edit a category" do
      get :edit, params: { id: @category.id }
      expect(response).to have_http_status(200)
    end

    it "returns error to edit for invalid category id" do
      get :edit, params: { id: "invalid_id" }
      expect(response).to redirect_to categories_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "PATCH#update" do
    login_admin
    it "update a category" do
      patch :update, params: { id: @category.id, category: @category.attributes }
      expect(response).to redirect_to categories_path
    end

    it "returns error to  update a sub category with  nil category name" do
      patch :update, params: { category: {category_name: nil}, id: @category.id }
      expect(response).to render_template(:edit)
    end

    it "returns error to update a category with invalid id" do
      patch :update, params: { id: 'invalid_id', category: @category.attributes }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to categories_path
    end

  end

  describe "DELETE#destroy" do
    login_admin
    it "destroys a category" do
      delete :destroy, params: { id: @category.id }
      category = Category.find_by(id: @category).present?
      expect(category).to eq(false)
      expect(response).to redirect_to categories_path
    end

    it "returns error for destroy with invalid category id" do
      delete :destroy, params: { id: 'invalid_id' }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to categories_path
    end
  end

  describe "GET#new_sub_category" do
    login_admin
    it "render new sub category" do
      get :new_sub_category, params: { id: @category.id }
      expect(response).to render_template(:new_sub_category)
    end
  end

  describe "POST#create_sub_category" do
    login_admin
    it "creates a new sub-category" do
      post :create_sub_category, params: { category: attributes_for(:category) ,id: @category.id }
      expect(response).to redirect_to sub_categories_path
      expect(flash[:notice]).to be_present
    end

    it "returns flash error for insufficient params " do
      post :create_sub_category, params: { category: {id: @sub_category.id},id: @category.id }
      expect(response).to redirect_to sub_categories_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "GET#edit_sub_category" do
    login_admin
    it "edit a sub_category" do
      get :edit_sub_category, params: { id: @category.id, sub_category_id: @sub_category.id}
      expect(response).to have_http_status(200)
    end

    it "returns flash error for invalid category id" do
      get :edit_sub_category, params: { id: "in", sub_category_id: "in" }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to sub_categories_path
    end

    it "returns flash error for invalid sub-category id" do
      get :edit_sub_category, params: { id: @category.id, sub_category_id: "invalid_id" }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to sub_categories_path
    end
  end

  describe "PATCH#update_sub_category" do
    login_admin
    it "should update a sub category" do
      patch :update_sub_category, params: { category: @category.attributes, id: @category.id, sub_category_id: @sub_category.id }
      expect(response).to redirect_to sub_categories_path
    end

    it "returns flash and redirect for invalid sub category_id" do
      patch :update_sub_category, params: { category: @category.attributes, id: "invalid_id", sub_category_id: "invalid_id" }
      expect(response).to redirect_to sub_categories_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "DELETE#destroy_sub_category" do
    login_admin
    it "destroy a sub-category" do
      delete :destroy_sub_category, params: { id: @category.id, sub_category_id: @sub_category.id}
      category = Category.find_by(id: @sub_category.id).present?
      expect(category).to eq(false)
      expect(response).to redirect_to sub_categories_path
    end

    it "returns flash error to destroy with invalid subcategory id" do
      delete :destroy_sub_category, params: { id: 'invalid_id', sub_category_id: 'invalid' }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to sub_categories_path
    end
  end
end

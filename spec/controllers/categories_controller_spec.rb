  # frozen_string_literal: true
  require 'rails_helper'

  RSpec.describe CategoriesController, type: :controller do
    login_user
    before(:each) do
      @category = create(:category)
      @sub_category = create(:category, primarycategory_id: @category.id)
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe "GET#show" do
      it "show returns a success response" do
        params = {id: @category.id}
        get :show, params: params
        expect(response).to have_http_status(200)
      end

      it "should show flash for invalid category" do
        params = {id: "invalid_id"}
        get :show, params: params
        expect(response).to redirect_to categories_path
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET#new" do
      login_admin
      it "only admin allowed to create" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "POST#create" do
      login_admin
      it "should create a new category" do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to categories_path
        expect(flash[:notice]).to be_present
      end

      it "should show error flash message for wrong / less atttributes" do
        post :create, params: { category: {id: @category.id} }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET#edit" do
      login_admin
      it "should edit a category" do
        get :edit, params: { id: @category.id }
        expect(response).to have_http_status(200)
      end

      it "should show flash and redirect for invalid category" do
        get :edit, params: { id: "invalid_id" }
        expect(response).to redirect_to categories_path
        expect(flash[:alert]).to be_present
      end

    end

    describe "PATCH#update" do
      login_admin
      it "should update a category" do
        patch :update, params: { id: @category.id, category: @category.attributes }
        expect(response).to redirect_to categories_path
      end
    end

    describe "DELETE#destroy" do
      login_admin
      it "should destroy a category" do
        delete :destroy, params: { id: @category.id }
        presence = Category.find_by(id: @category).present?
        expect(presence).to eq(false)
        expect(response).to redirect_to categories_path
      end
    end

    describe "GET#new_sub_category" do
      login_admin
      it "should render new" do
        get :new_sub_category, params: { id: @category.id }
        expect(response).to render_template(:new_sub_category)
      end
    end

    describe "POST#create_sub_category" do
      login_admin
      it "should create new sub-category" do
        post :create_sub_category, params: { category: attributes_for(:category) ,id: @category.id }
        expect(response).to redirect_to sub_categories_path
        expect(flash[:notice]).to be_present
      end

      it "should show error flash message " do
        post :create_sub_category, params: { category: {id: @sub_category.id},id: @category.id }
        expect(response).to render_template('categories/new_sub_category')
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET#edit_sub_category" do
      login_admin
      it "should edit sub_category" do
        get :edit_sub_category, params: { id: @category.id, sub_category_id: @sub_category.id}
        expect(response).to have_http_status(200)
      end

      it "should show flash and redirect for invalid category" do
        get :edit_sub_category, params: { id: "in", sub_category_id: "in" }
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to sub_categories_path
      end

      it "should show flash and redirect for invalid sub-category" do
        get :edit_sub_category, params: { id: @category.id, sub_category_id: "in" }
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

      it "should flash and redirect if error in update sub-category" do
        patch :update_sub_category, params: { category: @category.attributes, id: "1", sub_category_id: "invalid_id" }
        expect(response).to render_template('categories/edit_sub_category')
        expect(flash[:alert]).to be_present
      end
    end

    describe "DELETE#destroy_sub_category" do
      login_admin
      it "should destroy a sub-category" do
        delete :destroy, params: { id: @sub_category.id }
        presence = Category.find_by(id: @sub_category.id).present?
        expect(presence).to eq(false)
        expect(response).to redirect_to sub_categories_path
      end
    end
  end

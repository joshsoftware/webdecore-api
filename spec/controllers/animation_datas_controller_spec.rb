# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimationDatasController, type: :controller do
  login_user
  before do
    @category = create(:category)
    @sub_category = create(:category, primarycategory_id: @category.id)
    @animation = create(:animation_data, category_id: @sub_category.id)
  end

  describe "GET#show" do
    it "returns a animation of a category" do
      params = {id: @category.id, sub_category_id: @sub_category.id}
      get :show, params: params
      expect(response).to have_http_status(200)
    end

    it "returns flash error for invalid sub_category_id" do
      params = {id: @category.id, sub_category_id: "invalid_id"}
      get :show, params: params
      expect(response).to redirect_to sub_categories_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "GET#demo" do
    it "shows animation demo" do
      params = { id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id }
      get :demo, params: params
      expect(response).to have_http_status(200)
    end

    it "returns flash error for invalid animation id" do
      params = { id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: "invalid_id" }
      get :demo, params: params
      expect(response).to redirect_to animations_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "GET#new" do
    login_admin
    it "admin creates new animation - renders new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST#create" do
    login_admin
    it "admin creates a new animation" do
      post :create, params: { animation_datas: attributes_for(:animation_data), id: @category.id, sub_category_id: @sub_category.id }
      expect(response).to redirect_to animations_path
      expect(flash[:notice]).to be_present
    end

    it "returns flash error message for invalid atttributes" do
      post :create, params: { animation_datas: {animation_data_id: @animation.id}, id: "", sub_category_id: "" }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end

    it "return flash error for insufficient params" do
      post :create, params: { animation_datas: { id: @animation.id } }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end
  end

  describe "GET#edit" do
    login_admin
    it "edits a animation" do
      params = {id: @category.id, sub_category_id: @sub_category.id, animation_data_id: @animation.id}
      get :edit, params: params
      expect(response).to have_http_status(200)
    end

    it "returns flash error for empty ids" do
      params = {id: "", sub_category_id: "", animation_data_id: ""}
      get :edit, params: params
      expect(response).to redirect_to animations_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "PATCH#update" do
    login_admin
    it "updates a animation" do
      params = { animation_datas: attributes_for(:animation_data), id: @category.id, sub_category_id: @sub_category.id, animation_data_id: @animation.id }
      patch :update, params: params
      expect(response).to redirect_to animations_path
    end
  end

  describe "DELETE#destroy" do
    login_admin
    it "destroy a animation" do
      params = { id: @category.id, sub_category_id: @sub_category.id, animation_data_id: @animation.id }
      delete :destroy, params: params
      animation = AnimationData.find_by(id: @animation).present?
      expect(animation).to eq(false)
      expect(response).to redirect_to animations_path
      expect(flash[:alert]).to be_present
    end

    it "returns invalid animation id to destroy a animation" do
      params = { id: @category.id, sub_category_id: @sub_category.id, animation_data_id: 'invalid_id' }
      delete :destroy, params: params
      expect(response).to redirect_to animations_path
      expect(flash[:alert]).to be_present
    end
  end
end

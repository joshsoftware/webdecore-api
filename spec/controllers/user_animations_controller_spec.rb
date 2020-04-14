require 'rails_helper'

RSpec.describe UserAnimationsController do
  login_user
  before do
    @category = create(:category)
    @sub_category = create(:category, primarycategory_id: @category.id)
    @animation = create(:animation_data, category_id: @sub_category.id)
    @user_animation1 = create(:user_animation, status: 'Active', animation_data_id: @animation.id,
       location: 'Maharashtra', user_id: session["warden.user.user.key"][0][0])
    @user_animation2 = create(:user_animation, status: 'Active', animation_data_id: @animation.id,
       location: 'Maharashtra', user_id: session["warden.user.user.key"][0][0])
  end

  describe "GET#index" do
    it "returns list of animations purchased" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET#new" do
    it "creates new animation order - renders new" do
      get :new, params: {id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id}
      expect(response).to render_template(:new)
    end
  end

  describe "POST#create" do
    login_user
    it "creates a new animation order" do
      user_animation = {category_id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id}
      params = {user_animation: user_animation.merge!(attributes_for(:user_animation))}
      post :create, params: params
      expect(response).to redirect_to user_animations_path
    end

    it "returns error for previous date animation purchase" do
      user_animation = {category_id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id, start_date: '25-02-2020', end_date: '24-05-2020',
         frequency: 5, location: 'Maharashtra', price: '1000'}
      post :create, params: {user_animation: user_animation}
      expect(response).to redirect_to redirect_to purchase_path(id: @category.id,
         sub_category_id: @sub_category.id, animation_data_id: @animation.id)
    end

    it "returns flash error message for insufficient params" do
      post :create, params: {user_animation: {category_id: @category.id,
        sub_category_id: @sub_category.id, animation_data_id: @animation.id,
        start_date: '25-04-2020', end_date: '26-04-2020'} }
      expect(response).to redirect_to purchase_path(id: @category.id,
         sub_category_id: @sub_category.id, animation_data_id: @animation.id)
    end

    it "returns flash error message for same date animation" do
      user_animation = {category_id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id}
      params = {user_animation: {start_date: '25-04-2020', end_date: '26-04-2020',
        location: 'Maharashtra', frequency: 5, category_id: @category.id,
        sub_category_id: @sub_category.id, animation_data_id: @animation.id}}
      post :create, params: params
      params = {user_animation: {start_date: '25-04-2020', end_date: '26-04-2020',
        location: 'Maharashtra', frequency: 5, category_id: @category.id,
        sub_category_id: @sub_category.id, animation_data_id: @animation.id}}
      post :create, params: params
      expect(response).to redirect_to purchase_path(id: @category.id,
         sub_category_id: @sub_category.id, animation_data_id: @animation.id)
    end

    it "returns flash error message for same date animation" do
      user_animation = {category_id: @category.id, sub_category_id: @sub_category.id,
         animation_data_id: @animation.id}
      params = {user_animation: {start_date: '25-04-2020', end_date: '26-04-2020',
        location: 'Maharashtra', frequency: 5, category_id: @category.id,
        sub_category_id: @sub_category.id, animation_data_id: @animation.id}}
      post :create, params: params
      params = {user_animation: {start_date: '24-04-2020', end_date: '26-04-2020',
        location: 'Maharashtra', frequency: 5, category_id: @category.id,
        sub_category_id: @sub_category.id, animation_data_id: @animation.id}}
      post :create, params: params
      expect(response).to redirect_to purchase_path(id: @category.id,
         sub_category_id: @sub_category.id, animation_data_id: @animation.id)
    end
  end

  describe "GET#edit" do
    it "edits a animation order" do
      params = {id: @user_animation1.id}
      get :edit, params: params
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH#update" do
    it "updates a animation order" do
      params = {id: @user_animation1.id, user_animation: {location: 'Maharashtra',
         start_date: '25-05-2020', end_date: '27-05-2020', frequency: 5} }
      patch :update, params: params
      expect(response).to redirect_to user_animations_path
    end

    it "fails to update a animation order with invalid attributes" do
      params = {id: @user_animation1.id, user_animation: {location: nil,
         start_date: '25-05-2020', end_date: '27-05-2020'} }
      patch :update, params: params
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to user_animation_path
    end

    it "returns error to update animation with previous date" do
      params = {id: @user_animation1.id, user_animation: {start_date: '25-02-2020',
         end_date: '24-02-2020', frequency: 5, location: 'Maharashtra', price: '1000'} }
      patch :update, params: params
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to edit_user_animation_path
    end
  end

  describe "DELETE#destroy" do
    it "destroy a animation order" do
      params = { id: @user_animation1.id }
      delete :destroy, params: params
      presence = UserAnimation.find_by(id: @user_animation1.id).present?
      expect(presence).to eq(false)
      expect(response).to redirect_to user_animations_path
      expect(flash[:alert]).to be_present
    end

    it "returns error for invalid id of animation order" do
      params = { id: 111 }
      delete :destroy, params: params
      expect(response).to redirect_to user_animations_path
      expect(flash[:alert]).to be_present
    end
  end

  describe "Inactive#inactive" do
    it "inactive a animation order" do
      user_animation = create(:user_animation, status: 'Active', start_date: '25-02-2020',
         end_date: '24-02-2020', animation_data_id: @animation.id, location: 'Maharashtra',
         user_id: session["warden.user.user.key"][0][0])
      params = { id: user_animation.id  }
      get :inactive, params: params
      expect(response).to redirect_to user_animations_path
    end

    it "returns error for invalid id for inactive a animation order" do
      params = { id: 11 }
      get :inactive, params: params
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to user_animations_path
    end
  end
end

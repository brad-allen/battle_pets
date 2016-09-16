require 'test_helper'

class V1::BattlePetsControllerAuthTest < ActionController::TestCase
 include Devise::Test::ControllerHelpers
  setup do
    @battle_pet = battle_pets(:one)
    @controller = V1::BattlePetsController.new
  end

  test "unauthorized index should have access" do
    get :index, format: :json
    assert_response :success
  end

  test "unauthorized show should have access" do
    get :show, :id => 1, format: :json
    assert_response :success
  end

  test "unauthorized create should not have access" do
    post :create, format: :json
    assert_response :unauthorized
  end

  test "unauthorized update should not have access" do
    patch :update, :id => 1, format: :json
    assert_response :unauthorized
  end

  test "unauthorized battles should not have access" do 
    get :battles, :battle_pet_id => 1, format: :json
    assert_response :unauthorized
  end

  test "unauthorized leaderboard should have access" do 
    get :leaderboard, format: :json
    assert_response :success
  end

  test "unauthorized generate_pet should not have access" do 
    post :generate_pet, :battle_pet_id => 1, params:  { name: @battle_pet.name , auto_accept_play_for_points_requests: nil, galaxy: @battle_pet.galaxy,  id: nil, image: @battle_pet.image, status: nil  },  format: :json
    assert_response :unauthorized
  end

  test "unauthorized generate_training_pet should have access" do 
    get :generate_training_pet, :battle_pet_id => 1, format: :json
    assert_response :success
  end

  test "unauthorized train should should not have access" do 
    get :train, :battle_pet_id => 2, format: :json
    assert_response :unauthorized
  end

  test "authed_get_pet_for_battle should have client access regardless of user auth" do 
    @battle_pet.save
    @battle = battles(:one) 
    @battle.save

    post :authed_get_pet_for_battle, params: { call_auth_code: 'qwerty', battle_pet_id: 1}, format: :json
    assert_response :success
  end


end

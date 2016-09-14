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

=begin
#TODO this endpoint is currently not client authed, but needs to be
  test "authed_get should have client access" do 
    get :authed_get, :battle_pet_id => 1, format: :json
    assert response.body.include? 'Milky Way'
    assert response.body.include? 'wisdom'    
    assert_response :success
  end
=end

end

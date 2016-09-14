require 'test_helper'

class BattlesControllerTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @battle = battles(:one)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user = users(:one)
      sign_in user
      user.account = accounts(:one)
  end

  test "should get index" do
    get :index
   
    assert_response :success
  end

  test "should get new" do
    get :new
   
    assert_response :success
  end

  test "should create battle" do

    assert_difference('Battle.count') do
      post :create, params: { battle: { name: 'Battle', arena_id: @battle.arena_id, battle_game_id: @battle.battle_game_id, battled_on: @battle.battled_on, created_at: @battle.created_at, created_by: @battle.created_by, id: @battle.id, pet1_id: @battle.pet1_id, pet2_id: @battle.pet2_id, status: @battle.status, updated_at: @battle.updated_at, updated_by: @battle.updated_by, winning_user_id: @battle.winning_user_id, winning_pet_id: @battle.winning_pet_id, user1_id:@battle.user1_id, user2_id:@battle.user2_id } }
    end

    assert_redirected_to battle_url(Battle.last)
  end

  test "should show battle" do
    get :show, :id => 1
  
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => 1
  
    assert_response :success
  end

  test "should update battle" do
    patch :update, params: { id: 1, battle: { arena_id: @battle.arena_id, battle_game_id: @battle.battle_game_id, battled_on: @battle.battled_on, created_at: @battle.created_at, created_by: @battle.created_by, id: @battle.id, pet1_id: @battle.pet1_id, pet2_id: @battle.pet2_id, status: @battle.status, updated_at: @battle.updated_at, updated_by: @battle.updated_by, winning_user_id: @battle.winning_user_id, winning_pet_id: @battle.winning_pet_id, user1_id:@battle.user1_id, user2_id:@battle.user2_id } }
  
    assert_redirected_to battle_url
  end

end

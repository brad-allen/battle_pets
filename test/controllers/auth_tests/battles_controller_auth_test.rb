require 'test_helper'

class BattlesControllerAuthTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @redirect_url = 'http://test.host/users/sign_in'
      @battle = battles(:one)
      @controller = BattlesController.new
  end

   test "index should get redirected" do
    get :index

    assert_redirected_to @redirect_url
  end

  test "new should get redirected" do
    get :new

    assert_redirected_to @redirect_url
  end

  test "create should get redirected" do

    post :create, params: { battle: { name: @battle.name, arena_id: @battle.arena_id, battle_game_id: @battle.battle_game_id, battled_on: @battle.battled_on, created_at: @battle.created_at, created_by: @battle.created_by, id: @battle.id, pet1_id: @battle.pet1_id, pet2_id: @battle.pet2_id, status: @battle.status, updated_at: @battle.updated_at, updated_by: @battle.updated_by, winning_user_id: @battle.winning_user_id, winning_pet_id: @battle.winning_pet_id, user1_id:@battle.user1_id, user2_id:@battle.user2_id } }

    assert_redirected_to @redirect_url
  end

  test "show should get redirected" do
    get :show, :id => 1
    
    assert_redirected_to @redirect_url
  end

  test "edit should get redirected" do
    get :edit, :id => 1
    
     assert_redirected_to @redirect_url
  end

  test "update should get redirected" do
    patch :update, params: { id: 1, battle: { arena_id: @battle.arena_id, battle_game_id: @battle.battle_game_id, battled_on: @battle.battled_on, created_at: @battle.created_at, created_by: @battle.created_by, id: @battle.id, pet1_id: @battle.pet1_id, pet2_id: @battle.pet2_id, status: @battle.status, updated_at: @battle.updated_at, updated_by: @battle.updated_by, winning_user_id: @battle.winning_user_id, winning_pet_id: @battle.winning_pet_id, user1_id:@battle.user1_id, user2_id:@battle.user2_id } }
  
    assert_redirected_to @redirect_url
  end

end

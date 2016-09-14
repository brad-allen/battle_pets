require 'test_helper'

class BattlePetsControllerAuthTest < ActionController::TestCase


   include Devise::Test::ControllerHelpers
    setup do
      @redirect_url = 'http://test.host/users/sign_in'
      @battle_pet = battle_pets(:one)
      @controller = BattlePetsController.new
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
    post :create, params: { battle_pet: { about: @battle_pet.about, agility: @battle_pet.agility, auto_accept_play_for_points_requests: @battle_pet.auto_accept_play_for_points_requests, chi: @battle_pet.chi, created_at: @battle_pet.created_at, created_by: @battle_pet.created_by, account_id: @battle_pet.account_id, experience: @battle_pet.experience, galaxy: @battle_pet.galaxy, healing_power: @battle_pet.healing_power, image: @battle_pet.image, intelligence: @battle_pet.intelligence, level: @battle_pet.level, lost: @battle_pet.lost, magic: @battle_pet.magic,  name: @battle_pet.name, original_owner_id: @battle_pet.original_owner_id, planet: @battle_pet.planet, previous_owner_id: @battle_pet.previous_owner_id, retired: @battle_pet.retired, speed: @battle_pet.speed, status: @battle_pet.status, strength: @battle_pet.strength, tied: @battle_pet.tied, town: @battle_pet.town, updated_at: @battle_pet.updated_at, updated_by: @battle_pet.updated_by, wisdom: @battle_pet.wisdom, wit: @battle_pet.wit, won: @battle_pet.won } }
    
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
    patch :update, params: { id: 1,  battle_pet: { about: @battle_pet.about, agility: @battle_pet.agility, auto_accept_play_for_points_requests: @battle_pet.auto_accept_play_for_points_requests, chi: @battle_pet.chi, created_at: @battle_pet.created_at, created_by: @battle_pet.created_by, account_id: @battle_pet.account_id, experience: @battle_pet.experience, galaxy: @battle_pet.galaxy,  healing_power: @battle_pet.healing_power, id: @battle_pet.id, image: @battle_pet.image, intelligence: @battle_pet.intelligence, level: @battle_pet.level, lost: @battle_pet.lost, magic: @battle_pet.magic,  name: @battle_pet.name, original_owner_id: @battle_pet.original_owner_id, planet: @battle_pet.planet, previous_owner_id: @battle_pet.previous_owner_id, retired: @battle_pet.retired, speed: @battle_pet.speed, status: @battle_pet.status, strength: @battle_pet.strength, tied: @battle_pet.tied, town: @battle_pet.town, updated_at: @battle_pet.updated_at, updated_by: @battle_pet.updated_by, wisdom: @battle_pet.wisdom, wit: @battle_pet.wit, won: @battle_pet.won } }    
   
    assert_redirected_to @redirect_url
  end


end

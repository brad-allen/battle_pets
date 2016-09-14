require 'test_helper'
require "net/http"
require "uri"

class V1::BattlePetsControllerTest < ActionController::TestCase
 include Devise::Test::ControllerHelpers
  setup do
    @controller = V1::BattlePetsController.new
    @battle_pet = battle_pets(:one)
    @battle_pet.account = accounts(:one)
    @battle_pet.save   
    @battle = battles(:one) 
    @battle.save
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    user = users(:one)
    sign_in user
    user.account = accounts(:one)
  end

  test "should get index" do
    get :index, format: :json
    assert response.body.include? 'Milky Way'
    assert_response :success
  end

  test "should create battle_pet" do

    assert_difference('BattlePet.count') do
      post :create, params: { about: @battle_pet.about, agility: @battle_pet.agility, auto_accept_play_for_points_requests: @battle_pet.auto_accept_play_for_points_requests, chi: @battle_pet.chi, created_at: @battle_pet.created_at, created_by: @battle_pet.created_by, account_id: @battle_pet.account_id, experience: @battle_pet.experience, galaxy: @battle_pet.galaxy,  healing_power: @battle_pet.healing_power, id: @battle_pet.id, image: @battle_pet.image, intelligence: @battle_pet.intelligence, level: @battle_pet.level, lost: @battle_pet.lost, magic: @battle_pet.magic,  name: @battle_pet.name, original_owner_id: @battle_pet.original_owner_id, planet: @battle_pet.planet, previous_owner_id: @battle_pet.previous_owner_id, retired: @battle_pet.retired, speed: @battle_pet.speed, status: @battle_pet.status, strength: @battle_pet.strength, tied: @battle_pet.tied, town: @battle_pet.town, updated_at: @battle_pet.updated_at, updated_by: @battle_pet.updated_by, wisdom: @battle_pet.wisdom, wit: @battle_pet.wit, won: @battle_pet.won } , format: :json
    end

    assert_response :success
  end

  test "should show battle_pet" do
    get :show, :id => 1, format: :json
    assert_not response.body.include? 'wisdom'    
    assert_response :success
  end

  test "should update battle_pet" do
    patch :update, params: { about: @battle_pet.about, agility: @battle_pet.agility, auto_accept_play_for_points_requests: @battle_pet.auto_accept_play_for_points_requests, chi: @battle_pet.chi, created_at: @battle_pet.created_at, created_by: @battle_pet.created_by, account_id: @battle_pet.account_id, experience: @battle_pet.experience, galaxy: @battle_pet.galaxy,  healing_power: @battle_pet.healing_power, id: @battle_pet.id, image: @battle_pet.image, intelligence: @battle_pet.intelligence, level: @battle_pet.level, lost: @battle_pet.lost, magic: @battle_pet.magic,  name: @battle_pet.name, original_owner_id: @battle_pet.original_owner_id, planet: @battle_pet.planet, previous_owner_id: @battle_pet.previous_owner_id, retired: @battle_pet.retired, speed: @battle_pet.speed, status: @battle_pet.status, strength: @battle_pet.strength, tied: @battle_pet.tied, town: @battle_pet.town, updated_at: @battle_pet.updated_at, updated_by: @battle_pet.updated_by, wisdom: @battle_pet.wisdom, wit: @battle_pet.wit, won: @battle_pet.won }  , format: :json
    assert_response :success
  end

  test "authed_get should get detailed battle pet information" do 
    get :authed_get, :battle_pet_id => 1, format: :json
    assert response.body.include? 'Milky Way'
    assert response.body.include? 'wisdom'    
    assert_response :success
  end

  test "battles should get battle information for the pet" do 
    get :battles, :battle_pet_id => 1, format: :json
    assert response.body.include? 'qwerty'
    assert_response :success
  end

  test "leaderboard should get list of high point battle pets" do 
    get :leaderboard, format: :json
    assert response.body.include? 'Milky Way'
    assert_response :success
  end

  test "generate_pet should return the pet on a successful generation" do 
    post :generate_pet, :battle_pet_id => 1, params:  { name: @battle_pet.name , auto_accept_play_for_points_requests: nil, galaxy: @battle_pet.galaxy,  id: nil, image: @battle_pet.image, status: nil  },  format: :json
    assert response.body.include? 'Milky Way'
    assert_response :success
  end

  test "generate_training_pet should return a generated pet" do 
    get :generate_training_pet, :battle_pet_id => 1, format: :json
    assert response.body.include? 'Mr. Battle Pet'
    assert_response :success
  end

  test "train should return forbidden if the user does not own the battle pet" do 
    get :train, :battle_pet_id => 2, format: :json
    assert_response :forbidden
  end

   test "train should return not_found if the training pet does not exist" do 
    get :train, :battle_pet_id => -1, format: :json
    assert_response :not_found
  end

=begin
  #need to mock out call calls

  test "generate_pet should return internal_server_error on failed save" do 
    pending("battle pets test")
    post :generate_pet, :battle_pet_id => 1, params:  { name: @battle_pet.name , auto_accept_play_for_points_requests: nil, galaxy: @battle_pet.galaxy,  id: nil, image: @battle_pet.image, status: nil  },  format: :json    
    assert_response :internal_server_error
  end

  test "train should return Bad Gateway on a train request when the arena is not available" do 
    pending("battle pets test")
    post :train, :battle_pet_id => 1, format: :json
    assert_response :bad_gateway
  end

  test "train should return Ok on a successful train request" do 
    pending("battle pets test")
    post :train, :battle_pet_id => 1, format: :json
    puts response.body.inspect
    assert_response :success
  end
=end
end

require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @account = accounts(:one)
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

  test "should show account" do
    get :show, :id => 1
  
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => 1
  
    assert_response :success
  end

  test "should update account" do
    patch :update, params: { id: 1, account: {  about: @account.about, created_at: @account.created_at, created_by: @account.created_by, email: @account.email, experience: @account.experience, galaxy: @account.galaxy, gold: @account.gold, id: @account.id, image: @account.image, level: @account.level, lost: @account.lost, planet: @account.planet, tied: @account.tied, town: @account.town, updated_at: @account.updated_at, updated_by: @account.updated_by, username: @account.username, won: @account.won } }
  
    assert_redirected_to account_url
  end

end

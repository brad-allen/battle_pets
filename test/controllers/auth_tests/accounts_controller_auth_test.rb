require 'test_helper'

class AccountsControllerAuthTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @redirect_url = 'http://test.host/users/sign_in'
      @account = accounts(:one)
      @controller = AccountsController.new
  end

   test "index should get redirected" do
    get :index

    assert_redirected_to @redirect_url
  end

  test "new should get redirected" do
    get :new

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
    patch :update, params: { id: 1, account: {  about: @account.about, created_at: @account.created_at, created_by: @account.created_by, email: @account.email, experience: @account.experience, galaxy: @account.galaxy, gold: @account.gold, id: @account.id, image: @account.image, level: @account.level, lost: @account.lost, planet: @account.planet, tied: @account.tied, town: @account.town, updated_at: @account.updated_at, updated_by: @account.updated_by, username: @account.username, won: @account.won } }
  
    assert_redirected_to @redirect_url
  end

end

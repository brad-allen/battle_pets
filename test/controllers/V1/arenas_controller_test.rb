require 'test_helper'
require "net/http"
require "uri"

class V1::ArenasControllerTest < ActionController::TestCase
 include Devise::Test::ControllerHelpers
    setup do
      @controller = V1::ArenasController.new
      @arena = arenas(:one)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user = users(:one)
      sign_in user
      user.account = accounts(:one)
  end

  test "should get index" do
    get :index, format: :json
    assert_response :success
  end

  test "should create arena" do

    assert_difference('Arena.count') do
      post :create, params: { description: @arena.description, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } , format: :json
    end

    assert_response :success
  end

  test "should show arena" do
    get :show, :id => 1, format: :json
    assert_response :success
  end

  test "should update arena" do
    patch :update, params: { description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } , format: :json
    assert_response :success
  end

end

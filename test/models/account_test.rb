require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  	setup do
    	@test_item = accounts(:one)
	  	@test_item.user = users(:one)	  
  	end

  	test "should save with required data" do	 
	  assert @test_item.save
	end

  	test "should not save without required permission" do
	  @test_item.permission = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required status" do
	  @test_item.status = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required user_id" do
	  @test_item.user_id = nil
	
	  assert_not @test_item.save
	end

end

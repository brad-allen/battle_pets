require 'test_helper'

class ArenaTest < ActiveSupport::TestCase
	setup do
		@test_item = arenas(:one)  	
	end

  test "should save with required data" do	 
	  assert @test_item.save
	end

  	test "should not save without required name" do
	  @test_item.name = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required url" do
	  @test_item.url = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required port" do
	  @test_item.port = nil
	
	  assert_not @test_item.save
	end
end

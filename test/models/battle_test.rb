require 'test_helper'

class BattleTest < ActiveSupport::TestCase
 	setup do
    	@test_item = battles(:one) 
  	end

  	test "should save with required data" do	 
	  assert @test_item.save
	end

  	test "should not save without required name" do
	  @test_item.name = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required user1_id" do
	  @test_item.user1_id = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required user2_id" do
	  @test_item.user2_id = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required pet1_id" do
	  @test_item.pet1_id = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required pet2_id" do
	  @test_item.pet2_id = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required status" do
	  @test_item.status = nil
	
	  assert_not @test_item.save
	end

	test "should not save with an invalid status" do
	  @test_item.status = 'walrus'
	
	  assert_not @test_item.save
	end


=begin
	test "send_battle_to_arena should use the default arena when none are selected" do
		
		@test_item.arena_id = nil	  	
	  	@test_item.send_battle_to_arena



	  	assert @test_item
	end

	test "send_battle_to_arena should use the selected arena when one is selected" do
	
	end

	test "send_battle_to_arena should return false if the arena is not responsive" do
	  pending("stub out call to arena")
	  
	end

	test "send_battle_to_arena should return false if the arena is not responsive" do
	  pending("stub out call to arena")
	
	end
  	test "process_battle_results should handle a tie" do
	  pending("battle test")
	end

	test "process_battle_results rewards the winning user with winner gold" do
	  pending("battle test")
	end

	test "process_battle_results rewards the winning user with winner experience" do
	  pending("battle test")
	end

	test "process_battle_results rewards the losing user with loser experience" do
	  pending("battle test")
	end
	
	test "process_battle_results rewards the winning pet with winner experience" do
	  pending("battle test")
	end

	test "process_battle_results rewards the losing pet with loser experience" do
	  pending("battle test")
	end

	test "process_battle_results updates the winning users win count" do
	  pending("battle test")
	end

	test "process_battle_results updates the winning pets win count" do
	  pending("battle test")
	end

	test "process_battle_results updates the losing users lost count" do
	  pending("battle test")
	end

	test "process_battle_results updates the losing pets lost count" do
	  pending("battle test")
	end

	test "get_battle_from_response returns valid battle" do
	  pending("battle test")
	end

	test "create_training_battle returns valid training battle" do
	  pending("battle test")
	end

	test "process_battle_results should handle a -1 training user and pet" do
	  pending("battle test")
	end
=end
end
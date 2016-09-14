require 'test_helper'

class BattlePetTest < ActiveSupport::TestCase
  	setup do
    	@test_item = battle_pets(:one)
	  	@test_item.account = accounts(:one)	  
  	end

  	test "initialize_pet should create a pet with generated values" do
		@test_item.initialize_pet

		assert @test_item.status == 'active'

	end

	test "generate_training_battle_pet should create a pet at the specified level" do
		generated_pet = @test_item.generate_training_battle_pet

		assert generated_pet.level == @test_item.level
	end

	test "level_up should level up a pet if they meet the criteria" do
		@test_item.initialize_pet
		current_level =@test_item.level
		@test_item.experience += 1000

		@test_item.level_up

		assert @test_item.level == current_level+1

	end

	test "level_up should not level up a pet if they are not worthy" do
		@test_item.initialize_pet
		current_level =@test_item.level
		
		@test_item.level_up

		assert @test_item.level == current_level
	end

  	test "should save with required data" do	 
	  assert @test_item.save
	end

  	test "should not save without required status" do
	  @test_item.status = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required strength" do	  
	  @test_item.strength = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required agility" do
	  @test_item.agility = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required wit" do
	  @test_item.wit = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required speed" do
	  @test_item.speed = nil

	  assert_not @test_item.save
	end

	test "should not save without required wisdom" do
	  @test_item.wisdom = nil

	  assert_not @test_item.save
	end

	test "should not save without required intelligence" do
	  @test_item.intelligence = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required magic" do
	  @test_item.magic = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required chi" do
	  @test_item.chi = nil
	
	  assert_not @test_item.save
	end

	test "should not save without required healing_power" do
	  @test_item.healing_power = nil
	 
	  assert_not @test_item.save
	end


	test "should not save with invalid status" do
	  @test_item.status = 'where_am_i'
	  
	  assert_not @test_item.save
	end

end
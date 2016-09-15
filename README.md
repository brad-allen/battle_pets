#Battle Pets

Battle Pets is a multi service application that allows users to create battle pets (in the Battle Pet Manager) and then send them to different Arenas to battle in different battle games.

##How to Play 

A user can create an account and then generate battle pets.
The battle pets have some fields they can update and others that are auto generated when the pet is created.
These auto generated fields are battle characteristics like: strength, agility, speed, etc and they are used to help determine the winner of the battles.

Battle pets may also earn experience that eventually helps them to level up.  When a battle pet levels up, their battle characteristics also get a small boost, improving the pet's chance of winning battles.

When a battle pet has been created, the user can create a battle and invite another battle pet to the battle.
If the other battle pet accepts the battle request, the battle is sent to the specified arena url where the results are determined and then sent back to the Battle Pets Manager.  The manager takes those results and rewards the pets and users according to their results.
One pet almost alway wins the battle.  There is a slight possibility for a tie if all of their values and experience are exactly the same, but it is highly unlikely.

If a pet chooses to deny the battle request, they do not battle.
If a pet is set up to auto accept battles then they will auto accept any battle that is not a "Play for keeps" battle
Battles designated as play for keeps, give the winner the loser's pet at their completion.  Otherwise, players and pets only earn experience and gold for battles.

The battles games, or rules, are set up in the Arena where the pets battle.  Before creating a new battle, it is necessary to call the arena to see what battle games are available.  If an invalid value is passed in, it will simply perform the first battle game in the database.

An admin can add more arenas to the battle pets manager in order to allow new arena services  to be added to the Arena Empire.

##Architecture Notes

I chose Devise for user sign up and authentication due to its ease of use.  It isn't emailing at this time, but it does allow sign up, sign in and uses the proper auth throughout the applications.
Both the Pet Manager and the Arenas have different auth, so will require different sign ins as they would generally be managed by different teams.  You only need to sign into the Arena application if you are an admin planning on creating or editing battle games for the manager to select from, otherwise, signing into Battle Pets is sufficient to play.

I chose Sidekiq for the background task manager, which requires redis, as I have used both in the past and they seemed good for the task.

Along with authentication, I have also implemented permission checking on the endpoints to ensure only proper users can access them

Both applications have seeds that can be run which will populate the systems with initial battle games, admins and users, and add some battle_pets for those users.  It will also populate a few battle invites for users 1 and 2 and one "old" battle in the database

As these are separate services that could be managed by multiple groups, I opted to duplicate battle data in the arena they are run in and in the Pet Manager application.  This way, if one arena or the manager loses data, it will not affect the Arena's information.  It would be simple to create another Arena that does not save the data (because other than providing the fight and battle game endpoints, the arenas may follow their own rules), but instead calls the Pet Manager's endpoints in order to get that battle's data.  We could also create a separate app, an Arena Manager that holds and controls all of the results.

For backend communication, I opted with simple http requests to allow the services to be hosted separately.  In a truly separate environment, I would need to update it for CORS if the domains are different.

There are many things I would like to improve upon, many of which I would be sure to complete before going to production, and I have indicated them at the bottom in the To Do list.

##Admin CRUD

In order to facilitate administrative capabilities in the beginning, I have kept the basic crud controllers views and added admin auth to them.  This admin functionality is also included in the V1 endpoints and chances are the Crud UI would eventually be replaced by an app that uses those endpoints instead of the basic views.

##V1 Api Endpoints

I have implemented the following V1 API endpoints using JSON input of the form
	
	{'username':'Brad', 'user_id':1}

BattlePets

	Accounts

		PUT http://localhost:3000/v1/accounts/1  #update the account
		{:id, :username, :user_id, :about, :email, :image, :town, :planet, :galaxy)

		GET http://localhost:3000/v1/accounts  #list the accounts, filtered for users
		
		GET http://localhost:3000/v1/accounts/1  #list the account, filtered for users
		
		GET http://localhost:3000/v1/my_battle_pets  # my pets only, not filtered, uses auth cookie
		
		GET http://localhost:3000/v1/my_battles  # my battles only, uses auth cookie

		GET http://localhost:3000/v1/my_battle_requests  # my battle requests, uses auth cookie

		GET http://localhost:3000/v1/leaderboard # the leading users

		GET http://localhost:3000/v1/accounts/1/battle_pets  # the battle pets for this account, filtered for users
	  
		GET http://localhost:3000/v1/accounts/1/battles  # the battles for this account

		GET http://localhost:3000/v1/me  #my data, not filtered, uses auth cookie

	
	Arenas

		POST http://localhost:3000/v1/arenas  # create an arena - admin only
		{:name, :description, :rated, :url}
	
		PUT http://localhost:3000/v1/arenas/1  # update an arena - admin only
		{:id, :name, :description, :rated, :url}

		GET http://localhost:3000/v1/arenas #list the arenas
		
		GET http://localhost:3000/v1/arenas/1  #info on an arena
    
	
	Battles

		POST http://localhost:3000/v1/battles #create a battle
		{:name, :user1_id, :user2_id, :arena_id, :pet1_id, :pet2_id, :play_for_keeps, :winner_experience, :loser_experience, :winner_gold, :battle_game_id}

		PUT http://localhost:3000/v1/battles/1 #update a battle
		{:name, :user1_id, :user2_id, :arena_id, :pet1_id, :pet2_id, :play_for_keeps, :winner_experience, :loser_experience, :winner_gold, :battle_game_id}

		GET http://localhost:3000/v1/battles #list of all battles
		
		GET http://localhost:3000/v1/battles/1  #info on battle

		PUT http://localhost:3000/v1/battles/1/accept  #accept this battle requests

		PUT http://localhost:3000/v1/battles/1/deny  #deny this battle requests

		POST http://localhost:3000/v1/battles/1/battle_update # arena callback endpint, call is authed with token
		{:id, :battled_on, :winning_user_id, :winning_pet_id, :is_tie, :status, :original_id, :score, :call_auth_code}


	BattlePets

		PUT http://localhost:3000/v1/battle_pets/1 # update battle pet
		{:id, :name, :about, :image, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests}

		GET http://localhost:3000/v1/battle_pets  #list of battle pets
		
		GET http://localhost:3000/v1/battle_pets/1  #this battle pet

		GET http://localhost:3000/v1/battle_pets/1/authed_get #TODO client auth for call back of this data

		GET http://localhost:3000/v1/battle_pets/1/battles # the battles for this battle pet

		GET http://localhost:3000/v1/battle_pets/1/generate_training_pet  #creates a training pet but does not save it

		GET http://localhost:3000/v1/battle_pets/1/train  #train this pet with the default training settings

		GET http://localhost:3000/v1/pet_leaderboard  # the leading pets

		POST http://localhost:3000/v1/generate_pet  # generate and save a new pet for a user
		{:name, :about, :image, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests}

		POST http://localhost:3000/v1/battle_pets # create a battle pet with specific fields, admin only
		{:name, :about, :image, :level, :experience, :won, :lost, :tied, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests, :status, :current_owner_id, :previous_owner_id, :original_owner_id, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing_power}
		
	Making a new user
	
		Go to http://localhost:3000/users/sign_up
	
	Signing in 
	
		Go to http://localhost:3000/users/sign_in
		
	Right now, to sign out you need to drop your cookies or call...
	
		DESTROY http://localhost:3000/users/sign_out

BattleArena

	AdminUsers

		POST http://localhost:3001/v1/admin_users # create, admin only
		{:username, :permission, :status}
	
		PUT http://localhost:3001/v1/admin_users/1 # update, admin only
		{:username, :permission, :status}

		GET http://localhost:3001/v1/admin_users #list
		
		GET http://localhost:3001/v1/admin_users/1  #get

	BattleGames

		POST http://localhost:3001/v1/admin_users # create, admin only
		{:name, :description, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing, :status}

		PUT http://localhost:3001/v1/admin_users/1 # update, admin only
		{:name, :description, :strength, :agility, :wit, :speed, :wisdom, :intelligence, :magic, :chi, :healing, :status}

		GET http://localhost:3001/v1/admin_users #list battle games
		
		GET http://localhost:3001/v1/admin_users/1  #get battle game

	Battles

		GET http://localhost:3001/v1/battles #list battles
		
		GET http://localhost:3001/v1/battles/1  #get battle

		POST http://localhost:3001/v1/battles/1/fight #called by the Battle Pet Manager when ready to fight!
		{:id, :name, :description, :call_auth_code, :user1_id, :user2_id, :pet1_id, :pet2_id, :status, :battle_game_id}

	
	Making a new user
	
		Go to http://localhost:3001/users/sign_up
	
	Signing in 
	
		Go to http://localhost:3001/users/sign_in
	
	Right now, to sign out you need to drop your cookies or call...
	
		DESTROY http://localhost:3001/users/sign_out

To Dos

	Tests with auth tests - full controller coverage and model validations
	Move http calls to common service model(s)
	Better exception handling
	Logging
	Table indexes
	More encapsulation & refactoring
	Refactor routes


Using the applications

	You will need to install the devise and sidekiq gems

	For ease of use you will want to run the seeds provided for both applications.

In BattleArena

	Start redis in a window
	Start sidekiq in a window 

		bundle exec sidekiq
	
	Start the Arena with the appropriate port

		rails s -p 3001

In BattlePets
	
	Start the BattlePets application
		rails s -p 3000
	
Quick run:
	In BattlePets
		Login as the user:
			admin@battle.com
			Test1234!

			perform a training run with your battle pet

			http://localhost:3000/v1/battle_pets/1/train

			What happens...
			When the endpoint is called it creates a battle with a training pet.
			The battle is sent to the Arena where a battle takes place.  During the battle, the arena app calls back to the pet manager to get pet info and to get the generated training pet's info (the training pets values are based on your pet's level, so they are closely matched).
			When the battle is complete, the results are sent back to the manager to handle the battle rewards (experience and gold).

			If a battle pet's experience update from the battle causes them to level up, then they also get random small boosts to their battle characteristics to help them in future battles.

			Users can also get experience and gold from battles (and can level up, but not as often as pets), but I don't use those values yet (I was thinking of a magic item store where you can use the items in the battle).

			Note that Training exercises do not show up on your Win/Loss record (but experience and gold does), ony real battles with real battle pets.

Full use:
	In BattlePets
		Login as the user:
			admin@battle.com
			Test1234!

		Create a new battle pet

			POST http://localhost:3000/v1/generate_pet
				{:name, :about, :image, :town, :planet, :galaxy, :retired, :auto_accept_play_for_points_requests}

		Create a battle

			POST http://localhost:3000/v1/battles 
				{:name, :user1_id, :user2_id, :arena_id, :pet1_id, :pet2_id, :play_for_keeps, :winner_experience, :loser_experience, :winner_gold, :battle_game_id}

		
		JQuery Example
		Go to the Battle Pets domain or you will receive CORS complaints
		
		Load up jQuery
		
		var jq = document.createElement('script');
		jq.src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js";
		document.getElementsByTagName('head')[0].appendChild(jq);
		// ... give time for script to load, then type.
		jQuery.noConflict();

		Example via Ajax
		$.ajax({
                    type: 'POST',
                    url: "http://localhost:3000/v1/battles",
                    dataType: 'json',
                    data: {'arena_id': 1, "name":"test 1000", "user1_id":1, "user2_id":2, "pet1_id":1, "pet2_id":3, "winner_experience":100,
                			"loser_experience":100, 'battle_game_id':1, 'winner_gold':100}

                });

		Log off

		Login as the user you invited to view requests...
			POST http://localhost:3000/v1/my_battle_requests

		Login as the user you invited to battle and accept (or deny)...
			POST http://localhost:3000/v1/battles/:battle_id/accept

		The battle happens and is processed again, but this time with two real battling pets.
		The wins and losses are recorded for real battles.

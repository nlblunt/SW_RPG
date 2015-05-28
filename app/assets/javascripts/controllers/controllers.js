var appControllers = angular.module('appControllers', ['appDirectives', 'appServices']);

appControllers.controller('homeController', ['$scope', function($scope)
{
    	$scope.$root.display_title = "Title";
    	$scope.$root.metadescription = "Description";
    	$scope.$root.body_id = "welcome";
}]);

appControllers.controller('playerController', ['$scope', 'playerFactory', function($scope, playerFactory)
{
	$scope.alerts = [];

	$scope.$root.body_id = "player";

	//Is signed in?
	$scope.signed_in = false;
	//Player info from sign_in
	$scope.stage = "sign_in";
	
	
	//Check to see if player is signed in.
	playerFactory.playerCheck().$promise
	.then(function(result)
	{
		//Player is signed in
		$scope.player = result;
		$scope.signed_in = true;
		$scope.stage = "characterselect";
	},
	function()
	{
		$scope.signed_in = false;
	});
	
	//Remove Alerts
	$scope.closeAlert = function(index)
	{
		$scope.alerts.splice(index, 1);
	};
	
	//Sign player in.  Gets a player session.
	this.sign_in = function()
	{
		playerFactory.playerLogin($scope.sign_in)
		.then(
			function(result)
			{
				$scope.player = result;
				console.log(result);
				$scope.signed_in = true;
				$scope.stage = "characterselect";
			});

		return;
	};
	
	//Enter Edit Player Mode
	$scope.editPlayer = function()
	{
		$scope.stage = "editplayer";
	};
	
	//Saves player updates
	$scope.saveEditPlayer = function()
	{
		playerFactory.editAuthor($scope.player.user_id, $scope.player_edit)
		.then(function(result)
		{
			console.log("Update Successful");
			$scope.player = result;
			$scope.stage = "characterselect";
		},
		function()
		{
			console.log("update Failed");
		});
	};
	
	//Cancel edit without saving and return to Character Select screen
	$scope.cancelEditPlayer = function()
	{
		$scope.stage = "characterselect";
	};
	
	//Create a new Character stage
	$scope.newCharacter = function()
	{
		$scope.stage = "charactercreate-1";
		
		//Initialize career_skill_choices and specialization_skill_choices
		$scope.career_skill_choices = 4;
		$scope.specialization_skill_choices = 2;
		
		//Initialize the $scope.character MODEL
		$scope.character = {};

		//Get list of races
		playerFactory.getRacesList()
		.then(function(result)
		{
			//Load the results into $scope.races
			$scope.races = result;
			//Set the initial SELECT value
			$scope.character.race = $scope.races[0];
		});
		
		//Get list of careers
		playerFactory.getCareersList()
		.then(function(result)
		{
			//Load the results into $scope.careers
			$scope.careers = result;
			//Set the initial SELECT value
			$scope.character.career = $scope.careers[0];
			
			//Load the career specializations
			playerFactory.getCareerSpecializations($scope.character.career.id)
			.then(function(result)
			{
				$scope.specializations = result;
				$scope.character.specialization = $scope.specializations[0];
			});
		});
		
		
	};
	
	$scope.saveNewCharacter = function()
	{
		playerFactory.newPc($scope.player, $scope.character)
		.then(function(result)
		{
			//Saved.  Get new character data with inialized stats
			$scope.character = result;
			
			//Get the list of skills
			playerFactory.getPcCareerSkills($scope.character.id)
			.then(function(result)
			{
				$scope.skills = result;
				//Set next stage
				
				//Test for Human class
				if($scope.character.race == "Human")
				{
					$scope.stage = "charactercreate-human";
				}
				else
				{
					$scope.stage = "charactercreate-2";
				}
			});
		});
	};
	
	$scope.careerSelected = function()
	{
		//A career has been select.  Reload career specializations
		playerFactory.getCareerSpecializations($scope.character.career.id)
		.then(function(result)
		{
			$scope.specializations = result;
		});
	};
	
	$scope.increaseRankCareerInit = function(index, skill_id, use_xp)
	{
		console.log(index);
			playerFactory.increaseRank($scope.player.id, skill_id, use_xp)
			.then(function(result)
			{
				$scope.career_skill_choices = $scope.career_skill_choices - 1;
				$scope.alerts.push({msg: "Skill rank increased", type: "success"});
				$scope.skills.splice(index, 1);
			}
			,
			function(result)
			{
				$scope.alerts.push({msg: "Error: " + result.status, type: "danger"});
				console.log("Error: " + result.status);
			});
	};
	
	//Cancel create a new character.  Return to character select
	$scope.cancelNewCharacter = function()
	{
		$scope.stage = "characterselect";
	};
}]);
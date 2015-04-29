var appControllers = angular.module('appControllers', ['appDirectives', 'appServices']);

appControllers.controller('homeController', ['$scope', function($scope)
{
    	$scope.$root.display_title = "Title";
    	$scope.$root.metadescription = "Description";
    	$scope.$root.body_id = "welcome";
}]);

appControllers.controller('playerController', ['$scope', 'playerFactory', function($scope, playerFactory)
{
	$scope.$root.body_id = "player";

	//Is signed in?
	this.signed_in = false;
	$scope.signed_in = false;
	//Player info from sign_in
	this.player = null;
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
		$scope.stage = "charactercreate";
	};
	
	//Cancel create a new character.  Return to character select
	$scope.cancelNewCharacter = function()
	{
		$scope.stage = "characterselect";
	};
}]);
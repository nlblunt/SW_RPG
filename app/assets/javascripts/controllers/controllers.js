var appControllers = angular.module('appControllers', ['appDirectives', 'appServices']);

appControllers.controller('homeController', ['$scope', function($scope)
{
    	$scope.$root.display_title = "Title";
    	$scope.$root.metadescription = "Description"
    	$scope.$root.body_id = "welcome";
}]);

appControllers.controller('playerController', ['$scope', 'playerFactory', function($scope, playerFactory)
{
	$scope.$root.body_id = "player";

	//Is signed in?
	this.signed_in = false;
	//Player info from sign_in
	this.player = null;

	//Sign player in.  Gets a player session.
	this.sign_in = function()
	{
		playerFactory.playerLogin($scope.sign_in)
		.then(
			function(result)
			{
				this.player = result;
				this.signed_in = true;
			});

		return;
	};
}]);
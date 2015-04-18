(function()
{
	var swrpg = angular.module("swrpg",
	[
		'templates',
		'ngRoute',
		'ngResource',
		'ui.bootstrap',
		'appControllers',
		'appDirectives',
	]);

	swrpg.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider)
	{
		$locationProvider.hashPrefix('!');

		$routeProvider.when('/',
		{
			templateUrl: "html/index.html",
			controller: "homeController"
		})
		.when('/player',
		{
			templateUrl: "html/player.html",
			controller: "playerController"
		})
		.otherwise(
		{
			redirectTo: '/'
		});
	}]);
})();
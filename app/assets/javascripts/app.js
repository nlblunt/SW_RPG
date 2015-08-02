(function()
{
	var swrpg = angular.module("swrpg",
	[
		'templates',
		'ngRoute',
		'ngResource',
		'ngAnimate',
		'ui.bootstrap',
		'appControllers',
		'appDirectives',
		'appServices'
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
		.when('/gm',
		{
			templateUrl: "html/gm.html",
			controller: "gmController"
		})
		.otherwise(
		{
			redirectTo: '/'
		});
	}]);
})();
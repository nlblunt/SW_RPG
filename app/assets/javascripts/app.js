(function()
{
	var swrpg = angular.module("swrpg",
	[
		'templates',
		'ngRoute',
		'ngResource',
		'ui.bootstrap',
		'appControllers',
	]);

	swrpg.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider)
	{
		$locationProvider.hashPrefix('!');

		$routeProvider.when('/',
		{
			templateUrl: "html/index.html",
			controller: "homeController"
		})
		.otherwise(
		{
			redirectTo: '/'
		});
	}]);
})();
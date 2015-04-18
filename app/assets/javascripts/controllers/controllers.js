var appControllers = angular.module('appControllers', ['appDirectives']);

appControllers.controller('homeController', ['$scope', function($scope)
{
    	$scope.$root.display_title = "Title";
    	$scope.$root.metadescription = "Description"
    	$scope.$root.body_id = "welcome";
}]);

appControllers.controller('playerController', ['$scope', function($scope)
{
	$scope.$root.body_id = "player";
}])
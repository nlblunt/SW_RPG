var appControllers = angular.module('appControllers', []);

appControllers.controller('homeController', ['$scope', function($scope)
{
    	$scope.$root.display_title = "Title";
    	$scope.$root.metadescription = "Description"
    	$scope.$root.body_id = "home";
}]);
var app = angular.module('appDirectives',[]);

app.directive('pcSignIn', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/pcsignin.html'
    };
});

app.directive('pcSignedIn', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/pcsignedin.html'
	};
});
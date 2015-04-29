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

app.directive('characterSelect', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/characterselect.html'
    };
});

app.directive('editPlayer', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/editplayer.html'
    };
});

app.directive('characterCreate', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/charactercreate.html'
    };
});
var app = angular.module('appDirectives',[]);

app.directive('gmSignIn', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/gmsignin.html'
    };
});

app.directive('gmSignedIn', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/gmsignedin.html'
    };
});

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

app.directive('characterCreate2', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/charactercreate2.html'
    };
});

app.directive('characterCreate3', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/charactercreate3.html'
    };
});

app.directive('characterCreateHuman', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/charactercreatehuman.html'
    };
});

app.directive('characterSelected', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/characterselected.html'
    };
});

app.directive('characterOverview', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/character/overview.html'
	};
});

app.directive('characterSkills', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/character/skills.html'
	};
});

app.directive('characterEquipment', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/character/equipment.html'
	};
});

app.directive('characterOptions', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/character/options.html'
	};
});

app.directive('gmPcs', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/pcs.html'
    };
});

app.directive('gmGame', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game.html'
    };
});

app.directive('gmGameSessions', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/sessions.html'
    };
});

app.directive('gmGameOverview', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/overview.html'
    };
});

app.directive('gmGamePlayers', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/players.html'
    };
});

app.directive('overviewPc', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/overview/pc.html'
    };
});
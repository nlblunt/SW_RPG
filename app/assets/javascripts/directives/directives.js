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
        templateUrl: 'html/partials/createpc/characterselect.html'
    };
});

app.directive('editPlayer', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/editplayer.html'
    };
});

app.directive('characterCreate', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/charactercreate.html'
    };
});

app.directive('characterCreate2', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/charactercreate2.html'
    };
});

app.directive('characterCreate3', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/charactercreate3.html'
    };
});

app.directive('characterCreateHuman', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/charactercreatehuman.html'
    };
});

app.directive('characterSelected', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/createpc/characterselected.html'
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

app.directive('characterCombat', function()
{
	return{
		restrict: 'E',
		templateUrl: 'html/partials/character/combat.html'
	};
});

app.directive('gmPcs', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/pcs.html'
    };
});

app.directive('gmEquipment', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/equipment.html'
    };
});

app.directive('gmCampaignSetup', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/campaign_setup.html'
    };
});

app.directive('gmGame', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game.html'
    };
});

app.directive('gmCampaignSessions', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/sessions.html'
    };
});

app.directive('gmCampaignOverview', function()
{
    return{
        restrict: 'E',
        templateUrl: 'html/partials/gm/game/overview.html'
    };
});

app.directive('gmCampaignPlayers', function()
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
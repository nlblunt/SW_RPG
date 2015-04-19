var appServices = angular.module('appServices', ['ngResource', 'angularFileUpload']);

/* Factory for player resource */
appServices.factory('playerFactory', ['$resource', '$q', '$http', function($resource, $q, $http)
{
	var self = {};

	//Player object
	var player = $resource('/player/:id', {id:'@id'});

	//Player (user) session object
	var playerSession = $resource('/users/sign_in', {id: '@id'},
	{
		//Custom API to check if user signed in.
		playerCheck: {method:'GET', url:'/users/player_check'}
	});

	//Player Login
	self.playerLogin = function(login)
	{
		//Deferred promise
		var deferred = $q.defer();

		var player = new playerSession({username: login.username, password: login.password});

		//Attempt to save the session
		player.$save()
		.then(
			function(result)
			{
				deferred.resolve(result);
			},
			function(result)
			{
				deferred.reject(result);
			});

		//Return the results
		return deferred.promise;
	};

	return self;
}]);
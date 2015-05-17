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
	
	
	//Check to see if player is logged in already
	self.playerCheck = function()
	{
		//Return player info if signed in
		return playerSession.playerCheck();
	};
	

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
				console.log(result);
				deferred.resolve(result);
			},
			function(result)
			{
				deferred.reject(result);
			});

		//Return the results
		return deferred.promise;
	};

	//Edit the plater data with the server
	self.playerEdit = function(id, player)
	{
		var deferred = $q.defer();
		
		//Multi model update so use $http instead of $resource
		$http.patch('/player/'+ id, {user:{email: player.email, password: player.password, password_confirmation: player.password_confirmation},player:{name: player.name}})
        .then(function(result)
        {
            //returns updated author info
            deferred.resolve(result.data);
        });
        
        return deferred.promise;
	};
	
	//Get a list of races from the server
	self.getRacesList = function()
	{
		var deferred = $q.defer();

		$http.get('/race/index')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	//Get a list of careers from the server
	self.getCareersList = function()
	{
		var deferred = $q.defer();
		
		//Career list API
		$http.get('/career/index')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	
	return self;
}]);
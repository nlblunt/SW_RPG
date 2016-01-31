var appServices = angular.module('appServices', ['ngResource', 'ngFileUpload']);

/* Factory for GM resource */

appServices.factory('gmFactory', ['$resource', '$q', '$http', function($resource, $q, $http)
{
	var self = {};
	
	//GM session object
	var gm = $resource('/gms/sign_in', {id:'@id'},
	{
		gmCheck: {method:'GET', url:'/gm/gm_check'},
	});
	
	self.gmCheck = function()
	{
		//Return gm info if signed in
		return gm.gmCheck();
	};
	
	//GM Login
	self.gmLogin = function(login)
	{
		var deferred = $q.defer();
		
		var new_gm = new gm({email: login.email, password: login.password});
		
		//Attempt to save the session
		new_gm.$save()
		.then(
			function(result)
			{
				deferred.resolve(result);
			},
			function()
			{
				deferred.reject();
			});
			
			return deferred.promise;
	};
	
	self.gmGetAllPcs = function()
	{
		//Gets all PCS regardless of status
		var deferred = $q.defer();
		
		$http.post('/gm/get_all_pcs.json')
		.success(function(result)
		{
			//Resolve the results
			deferred.resolve(result);
		});
		
		//Return the list of PCS
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
	
	self.getPcSkills = function(pc_id)
	{
		var deferred = $q.defer();
		
		$http.post('/player/get_pc_skills.json', {id: pc_id})// + pc_id + '.json')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.deletePc = function(pc_id)
	{
		var deferred = $q.defer();
		
		$http.post('/player/delete_pc.json',{id: pc_id})
		.then(function()
		{
			deferred.resolve();
		});
		
		return deferred.promise;
	};
	
	self.modifyPc = function(pc, skills)
	{
		//Modify a PC.  This is a GM function.  Get PC and SKILLs and send to server
		var deferred = $q.defer();
		
		$http.post('/gm/modify_pc.json', {pc: pc, skills: skills})
		.then(function()
		{
			deferred.resolve();
		});
		
		return deferred.promise;
	};
	
	self.getAllSessions = function()
	{
		//Get all sessions
		var deferred = $q.defer();
		
		$http.get('/game/get_all_sessions')
		.then(function(result)
		{
			console.log(result.data);
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.createSession = function(name, description)
	{
		//Create a new game session
		var deferred = $q.defer();
		
		$http.post('/game/create_session', {session:{name: name, description: description, status: "active"}})
		.then(function(result)
		{
			console.log(result.data);
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.restoreSession = function(id)
	{
		//Get the session info from the server
		var deferred = $q.defer();
		
		$http.post('/game/restore_session', {id: id})
		.then(function(result)
		{
			//Return the session
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
    //Add PC to current session
    self.addPcToSession = function(session_id, pc_id)
    {
        var deferred = $q.defer();
        
        $http.post('/gm/add_session_pcs', {s_id: session_id, pc_id: pc_id})
        .then(function(result)
        {
            deferred.resolve(result.data);
        });
        
        return deferred.promise;
    };
    
	self.getSessionPcs = function(session_id)
	{
		//Get the PCs in the session
		var deferred = $q.defer();
		
		$http.post('/game/get_session_pcs', {session_id: session_id})
		.then(function(result)
		{
			deferred.resolve(result);
		});
		
		return deferred.promise;
	};
	
	self.getNonSessionPcs = function(session_id)
	{
		//Get the PCs that are not in the session
		var deferred = $q.defer();
		
		$http.post('/game/get_non_session_pcs', {session_id: session_id})
		.then(function(result)
		{
			//Return the list of PCs that are not in the current game session
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
    
    //Modify player strain (strain)
    self.pcModifyStrain = function(pc_id, amount)
    {
        //Modifiy 'pc_id' strain by 'amount'
        
        var deferred = $q.defer();
        
        $http.post('/gm/pc_modify_strain', {id: pc_id, amount: amount})
        .then(function(result)
        {
            deferred.resolve(result.data);
        });
        
        return deferred.promise;
    };
    
    //Modify player health (wounds)
    self.pcModifyWounds = function(pc_id, amount)
    {
    	//Modify 'pc_id' health by 'amount'

    	var deferred = $q.defer();

    	$http.post('/gm/pc_modify_wounds', {id: pc_id, amount: amount})
    	.then(function(result)
    	{
    		deferred.resolve(result.data);
    	});

    	return deferred.promise;
    };
    
	return self;
}]);

/* Factory for player resource */
appServices.factory('playerFactory', ['$resource', '$q', '$http', function($resource, $q, $http)
{
	var self = {};

	//Player object
	var player = $resource('/player/:id', {id:'@id'},
	{
		createPc: {method: 'POST', url:'/player/create_pc'}
	});

	//Player (user) session object
	var playerSession = $resource('/users/sign_in', {id: '@id'},
	{
		//Custom API to check if user signed in.
		playerCheck: {method:'GET', url:'/users/player_check'}
	});
	
	//PC (Player Character) object
	var pc = $resource('/pc/:id', {id:'@id'});
	
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
	
	self.getPlayerPcs = function(player_id)
	{
		var deferred = $q.defer();
		
		$http.post('/player/get_player_pcs.json', {id: player_id})
		.success(function(result)
		{
			console.log(result);
			deferred.resolve(result);
		})
		.error(function()
		{
			deferred.reject("Error");
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
	
	self.newPc = function(player, character)
	{
		var deferred = $q.defer();
		
		$http.post('/player/create_pc', {id: player.id, pc:{name: character.name, race_id: character.race.id, career_id: character.career.id}})
		.then(function(result)
		{
			//Return new pc data
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.getPc = function(pc_id)
	{
		//Get the data for the PC
		var deferred = $q.defer();
		
		$http.get('/player/get_pc/'+ pc_id + ".json")
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.getPcSkills = function(pc_id)
	{
		var deferred = $q.defer();
		
		$http.post('/player/get_pc_skills.json', {id: pc_id})
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.getPcCareerSkills = function(pc_id)
	{
		var deferred = $q.defer();
		
		$http.get('/player/get_pc_career_skills/' + pc_id + '.json')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.getSpecializationCareerSkills = function(spec_id)
	{
		var deferred = $q.defer();
		
		$http.get('/career/get_specialization_career_skills/' + spec_id + '.json')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.getPcXp = function(pc_id)
	{
		var deferred = $q.defer();
		
		$http.get('/player/get_pc_xp/' + pc_id + '.json')
		.then(function(result)
		{
			deferred.resolve(result.data);
		});
		
		return deferred.promise;
	};
	
	self.increaseRank = function(pc_id, s_id, xp)
	{
		//Increase a skill rank by id.  use_xp determins to use xp or not
		var deferred = $q.defer();
		
		$http.post('/player/increase_skill_rank/', {id: pc_id, skill_id: s_id, use_xp: xp})
		.success(function(result)
		{
			//Return success
			deferred.resolve(result);
		})
		.error(function(result)
		{
			deferred.reject(result);
		});
		
		return deferred.promise;
	};
	
	self.increaseAttribute = function(pc_id, attrib)
	{
		//Increase attribute.  Only available during character creation
		var deferred = $q.defer();
		
		$http.post('/player/increase_attribute/', {id: pc_id, attribute: attrib})
		.success(function(result)
		{
			//Return success
			deferred.resolve(result);
		})
		.error(function(result)
		{
			deferred.reject(result);
		});
		
		return deferred.promise;
	};
	
	self.getCareerSpecializations = function(career_id)
	{
		var deferred = $q.defer();

		$http.get('/career/get_career_specializations/' + career_id + '.json')
		.success(function(result)
		{
			//Return specializations
			deferred.resolve(result);
		});
		
		return deferred.promise;
	};
	
	self.getAllSpecializations = function()
	{
		var deferred = $q.defer();
		
		$http.get('/career/get_all_specializations.json')
		.success(function(result)
		{
			//Return all specializations
			deferred.resolve(result);
		});
		
		return deferred.promise;
	};
	
	self.setSpecialization = function(pc_id, s_id, xp)
	{
		var deferred = $q.defer();
		console.log(pc_id);
		console.log(s_id);
		console.log(xp);
		
		$http.post('/player/set_specialization/', {id: pc_id, spec_id: s_id, use_xp: xp})
		.success(function(result)
		{
			//Return result
			deferred.resolve(result);
		})
		.error(function(result)
		{
			deferred.reject(result);
		});
		
		return deferred.promise;
	};
	
	self.setPcStatus = function(pc_id, status)
	{
		var deferred = $q.defer();
		
		//Set the pc status
		$http.post('/player/set_pc_status/', {id: pc_id, status: status})
		.success(function()
		{
			deferred.resolve();
		});
		
		return deferred.promise;
	};
	
	return self;
}]);
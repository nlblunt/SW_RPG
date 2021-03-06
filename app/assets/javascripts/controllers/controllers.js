var appControllers = angular.module('appControllers', ['appDirectives', 'appServices']);

appControllers.controller('homeController', ['$scope', function($scope)
{
   $scope.$root.display_title = " : Edge Of The Galaxy";
   $scope.$root.metadescription = "Description";
   $scope.$root.body_id = "welcome";
}]);

appControllers.controller('gmController', ['$scope', 'gmFactory', 'ngDialog', function($scope, gmFactory, ngDialog)
{
	//Controller for GameMaster (GM)
	
	//Set the main body tag to "gm"
	$scope.$root.body_id = "gm";
	
	//Container for session_pcs
	$scope.session_pcs = [];
	
	//Empty game session
	$scope.current_session = "";

	//Set gm_game_stage
	$scope.gm_game_stage = "gm_stage_sessions";
	
	//GM Messages
	$scope.messages = [];

	//Is GM signed in?  Set initial check to false then queue server
	gmFactory.gmCheck().$promise
	.then(function(result)
	{
		//GM is signed in
		$scope.gm_signed_in = true;
		$scope.gm_stage = "gmoverview";
	},
	function()
	{
		//GM is not signed in
		$scope.gm_signed_in = false;
	});
	
	
	/* OPEN DIALOG FUNCTIONS */
	$scope.open_new_weapon_dialog = function(index, type, weapon)
	{
        if(type == "edit")
        {
            $scope.weapon = weapon;
            $scope.type = "edit";
            $scope.index = index;
        }
        else
        {
            $scope.weapon = "";
            $scope.type = "new";
        }
        
		ngDialog.open({template: 'html/dialogs/new_weapon_dialog.html',
					  controller: 'gmController',
					  scope: $scope});
	};
	
	$scope.open_new_armor_dialog = function(index, type, armor)
	{
        if(type == "edit")
        {
            $scope.armor = armor;
            $scope.type = "edit";
            $scope.index = index;
        }
        else
        {
            $scope.armor = "";
            $scope.type = "new";
        }
        
		ngDialog.open({template: 'html/dialogs/new_armor_dialog.html',
					  controller: 'gmController',
					  scope: $scope});
	};
	
	$scope.open_new_item_dialog = function(index,type, item)
	{
        if(type == "edit")
        {
            $scope.item = item;
            $scope.type = "edit";
            $scope.index = index;
        }
        else
        {
            $scope.item = "";
            $scope.type = "new";
        }
        
		ngDialog.open({template: 'html/dialogs/new_item_dialog.html',
					   controller: 'gmController',
					  scope: $scope});
	};
    
    $scope.open_add_weapon_pc_dialog = function()
    {
        //Get the list of game weapons
        $scope.weapons = gmFactory.getWeapons();
        
        ngDialog.open({template: 'html/dialogs/add_weapon_pc.html',
                      controller: 'gmController',
                      scope: $scope});
    };
    
    $scope.open_add_armor_pc_dialog = function()
    {
        //Get the list of game armor
        $scope.armors = gmFactory.getArmors();

        ngDialog.open({template: 'html/dialogs/add_armor_pc.html',
                      controller: 'gmController',
                      scope: $scope});      
    };
    
    $scope.open_add_item_pc_dialog = function()
    {
        //Get the list of game items
        $scope.items = gmFactory.getItems();
        
        ngDialog.open({template: 'html/dialogs/add_item_pc.html',
                      controller: 'gmController',
                      scope: $scope});
    };
	/* END OPEN DIALOG FUNCTIONS */
	
	
	$scope.gm_sign_in = function()
	{
		gmFactory.gmLogin($scope.sign_in)
		.then(function()
		{
			$scope.gm_signed_in = true;
			$scope.gm_stage = "gmoverview";
		});
	};
	
	$scope.gm_set_stage = function(stage)
	{
		$scope.gm_stage = stage;
		
		if(stage == 'gm_pcs')
		{
			//PCS stage.  Get a list of PCS
			gmFactory.gmGetAllPcs()
			.then(function(result)
			{
				//Save the list of PCS
				$scope.pcs = result;
				
				//Get races and careers
				gmFactory.getRacesList()
				.then(function(result)
				{
					$scope.races = result;
				});
				
				gmFactory.getCareersList()
				.then(function(result)
				{
					$scope.careers = result;
				});
			});
		}

		if(stage == "gm_campaign_select")
		{
			gmFactory.getAllSessions()
			.then(function(result)
			{
				$scope.sessions = result;
			});
		}

		if(stage == "gm_equipment")
		{
			//Get the list of game weapons
			$scope.weapons = gmFactory.getWeapons();

		 //Set the 'ranges' available for adding new weapons
			$scope.ranges = ["Ranged - Light", "Ranged - Medium","Ranged - Long"];
			
			//Get the list of game armor
			$scope.armors = gmFactory.getArmors();
            
            //Get the list of game items
            $scope.items = gmFactory.getItems();
		};
	};
	
	$scope.edit_pc = function(index)
	{
		//Save the index incase of delete
		$scope.pc_index = index;
		
		//Create empty skills array incase of skill adjustment
		$scope.modified_skills = {};
		
		//Set $scope.changed_skills = 0 for display
		$scope.changed_skills = 0;
		
		//Edit a PC.  Get the pc from the index.  Set edit_pc = true
		$scope.character = $scope.pcs[index];
		
		//Set the selected race
		//TODO: Change to a more reliable method
		$scope.character.race = $scope.races[$scope.character.race_id - 1];
		
		//Set the selected career
		$scope.character.career = $scope.careers[$scope.character.career_id - 1];
		
		//Get the list of skills for the PC
		gmFactory.getPcSkills($scope.character.id)
		.then(function(result)
		{
			$scope.skills = result;
		});
		
        console.log("test");
        console.log($scope.character);
		$scope.edit_pc_state = true;
	};
	
	$scope.close_edit_pc_state = function()
	{
		$scope.edit_pc_state = false;
	};
	
	$scope.skill_rank_changed = function(skill, value)
	{
		//Convert to an integer
		skill.rank = parseInt(value, 10);
		
		//Add the modified skill to the modified_skills
		$scope.modified_skills[skill.name] = skill;
		
		//Update the changed skill count
		$scope.changed_skills = Object.keys($scope.modified_skills).length;
		console.log($scope.modified_skills);
	};
	
	$scope.delete_pc = function(pc_id)
	{
		gmFactory.deletePc(pc_id)
		.then(function()
		{
			//Delete was successful.  Reload PC and close edit screen (just splice for now)
			console.log("Delete pc");
			$scope.edit_pc_state = false;
			$scope.pcs.splice($scope.pc_index, 1);
		});
	};
	
	$scope.gm_modify_pc = function()
	{
		//Modify the selected PC
		gmFactory.modifyPc($scope.character, $scope.skills)
		.then(function()
		{
			//Modification was successful
			console.log("Modification successful");
			gmFactory.gmGetAllPcs()
			.then(function(result)
			{
				$scope.pcs = result;
			});
			
			$scope.edit_pc_state = false;
		});
	};
	
	$scope.set_game_stage = function(stage)
	{
		$scope.gm_game_stage = stage;
		
		//IF stage = sessions load sessions
		if(stage == "gm_game_sessions")
		{
			gmFactory.getAllSessions()
			.then(function(result)
			{
				$scope.sessions = result;
			});
		}
	};
	
	$scope.create_session = function()
	{
		//Create a new game session
		gmFactory.createSession($scope.new_session.name, $scope.new_session.description)
		.then(function(result)
		{
			//New session.  Save in $scope
			$scope.current_session = result;
			$scope.new_session = "";
			
			$scope.sessions.push(result);
			
			//Set the lists of PCs
			gmFactory.gmGetAllPcs()
			.then(function(result)
			{
				$scope.all_pcs = result;
				$scope.manage_game_pcs = "false";
			});
		});
	};
	
	$scope.restore_session = function(session_id)
	{
		//Restore a previous session
		gmFactory.restoreSession(session_id)
		.then(function(result)
		{
			//Save the returned session
			$scope.current_session = result;
			
			//Set the lists of PCs
			gmFactory.gmGetAllPcs()
			.then(function(result)
			{
				$scope.all_pcs = result;
				$scope.manage_game_pcs = "false";
			});
		});
	};
	
	$scope.manage_pcs = function(state)
	{
		//Sets the state for manage_game_pcs.  If true, show PC list
		$scope.manage_game_pcs = state;
	};
	
	$scope.add_pc_to_session = function(index)
	{
		//Add PC to sessions_pc
		$scope.session_pcs.push($scope.all_pcs[index]);
		
		console.log($scope.session_pcs);
		//Remove pc from Add List
		$scope.all_pcs.splice(index, 1);
	};
	
	$scope.show_selected_info = function(type, object)
	{
		//Shows the selected object in the information section.  Type determins layout
		$scope.info_type = type;
        
        if(type == 'pc')
            {
                
            }
		$scope.info_object = object;
		console.log(object);
	};
    
    //GM OVERVIEW: Add / Remove strain
    $scope.modify_strain = function(pc_id, amount)
    {
        gmFactory.pcModifyStrain(pc_id, amount)
        .then(function(result)
        {
            $scope.info_object.strain_current = result.strain;
            $scope.messages.unshift(result.time + ": " + result.msg);
        })
    };

    //GM OVERVIEW: Add / Remove wounds
    $scope.modify_wounds = function(pc_id, amount)
    {
    	gmFactory.pcModifyWounds(pc_id, amount)
    	.then(function(result)
    	{
    		$scope.info_object.wounds_current = result.wounds;
    		$scope.messages.unshift(result.time + ": " + result.msg);
    	})
    }
	
	/*GM EQUIPMENT MANAGEMENT*/
	//Save the new weapon
	$scope.save_weapon = function()
	{
		//Save the weapon from the form
		gmFactory.addWeapon($scope.weapon);
		
		//Push the new weapon into the weapons list
    	$scope.weapons.push($scope.weapon);
		
		//Clear out the form inputs
		$scope.weapon = "";
		
		//Close the dialog box
		ngDialog.close();
	};
    
    //Delete the weapon
    $scope.delete_weapon = function(index, w_id)
    {
        //Delete the weapon
        gmFactory.deleteWeapon(w_id);
        $scope.weapons.splice(index, 1);
    };
    
    //Edit the weapon
    $scope.edit_weapon = function()
    {
        //Edit the armor
        gmFactory.editWeapon($scope.weapon);
        
        //Update the list without recalling server
        $scope.weapons.splice($scope.index, 1);
        $scope.weapons.push($scope.weapon);
        
        //Clear out the form inputs
        $scope.weapon = "";
        
        //Close the dialog box
        ngDialog.close();
    };
	
    //Add the weapon to the PC
    $scope.add_weapon_to_pc = function(index, w_id)
    {
        gmFactory.addWeaponToPc($scope.character.id, w_id)
        .then(function()
        {
            //Success.  Push item to PC to avoid API call
            $scope.character.weapons.push($scope.weapons[index]);
            
            //TODO Modify API call to refresh current player to get weapon ID
        });
        
        //Close the dialog box
        ngDialog.close();
        
        return;
    };
    
    //Delete the weapon from the PC
    $scope.delete_weapon_from_pc = function(index, id)
    {
        gmFactory.deleteWeaponFromPc(id)
        .then(function(result)
        {
            //Success
            console.log(result);
            
            //Remove item from player screen
            $scope.character.weapons.splice(index,1);
        },
        function(result)
        {
            console.log(result);
        });
    };
    
	//Save the new armor
	$scope.save_armor = function()
	{
		//Save the armor from the form
		gmFactory.addArmor($scope.armor);
		
		//Push the new armor into the armor list
		$scope.armors.push($scope.armor);
		
		//Clear out the form inputs
		$scope.armor = "";
		
		//Close the dialog box
		ngDialog.close();
	};
    
    //Delete the armor
    $scope.delete_armor = function(index, a_id)
    {
        //Delete the armor
        gmFactory.deleteArmor(a_id);
        $scope.armors.splice(index,1);
    };
    
    //Edit the armor
    $scope.edit_armor = function()
    {
        //Edit the armor
        gmFactory.editArmor($scope.armor);
        
        //Update the list without recalling server
        $scope.armors.splice($scope.index, 1);
        $scope.armors.push($scope.armor);
        
        //Clear out the form inputs
        $scope.armor = "";
        
        //Close the dialog box
        ngDialog.close();
    };
    
    //Add the armor to the PC
    $scope.add_armor_to_pc = function(index, a_id)
    {
        gmFactory.addArmorToPc($scope.character.id, a_id)
        .then(function()
        {
            //Success.  Push item to PC to avoid API call
            $scope.character.armors.push($scope.armors[index]);
            
            //TODO Modify API call to refresh current player to get weapon ID
        });
        
        //Close the dialog box
        ngDialog.close();
        
        return;
    };
    
    //Delete the armor from the PC
    $scope.delete_armor_from_pc = function(index, id)
    {
        gmFactory.deleteArmorFromPc(id)
        .then(function(result)
        {
            //Success
            console.log(result);
            
            //Remove item from player screen
            $scope.character.armors.splice(index,1);
        },
        function(result)
        {
            console.log(result);
        });
    };
    
	//Save the new item
	$scope.save_item = function()
	{
		//Save the item from the form
		gmFactory.addItem($scope.item);
		
		//Push the new item into the item list
		$scope.items.push($scope.item);
		
		//Clear out the form inputs
		$scope.item = "";
		
		//Close the dialog box
		ngDialog.close();
	};
    
    //Delete the item
    $scope.delete_item = function(index, i_id)
    {
        //Delete the ittm
        gmFactory.deleteItem(i_id);
        $scope.items.splice(index,1);
    };
    
    //Edit the item
    $scope.edit_item = function()
    {
        //Edit the armor
        gmFactory.editItem($scope.item);
        
        //Update the list without recalling server
        $scope.items.splice($scope.index, 1);
        $scope.items.push($scope.item);
        
        //Clear out the form inputs
        $scope.item = "";
        
        //Close the dialog box
        ngDialog.close();
    }
    
    //Add the item to the PC
    $scope.add_item_to_pc = function(index, i_id)
    {
        gmFactory.addItemToPc($scope.character.id, i_id)
        .then(function()
        {
            //Success.  Push item to PC to avoid API call
            $scope.character.items.push($scope.items[index]);
            
            //TODO Modify API call to refresh current player to get weapon ID
        });
        
        //Close the dialog box
        ngDialog.close();
        
        return;
    };
    
    //Delete the item from the PC
    $scope.delete_item_from_pc = function(index, id)
    {
        gmFactory.deleteItemFromPc(id)
        .then(function(result)
        {
            //Success
            console.log(result);
            
            //Remove item from player screen
            $scope.character.items.splice(index,1);
        },
        function(result)
        {
            console.log(result);
        });
    };
	/*END GM EQUIPMENT MANAGEMENT*/

}]);

appControllers.controller('playerController', ['$scope', '$filter', '$interval', 'playerFactory', function($scope, $filter, $interval, playerFactory)
{
	$scope.alerts = [];

	$scope.$root.body_id = "player";

	//Is signed in?
	$scope.signed_in = false;
	//Player info from sign_in
	$scope.stage = "sign_in";
	
	//Timer
	var tmr_attr_update;
	var tmr_skills_update;
	
	//Check to see if player is signed in.
	playerFactory.playerCheck().$promise
	.then(function(result)
	{
		//Player is signed in
		$scope.player = result;
		$scope.signed_in = true;
		$scope.stage = "characterselect";
		
		//Get a list of players PCs
		playerFactory.getPlayerPcs($scope.player.id)
		.then(function(result)
		{
			//Assign the list of PCs to $scope.pcs
			$scope.pcs = result;
		});
	},
	function()
	{
		$scope.signed_in = false;
	});
	
	//Remove Alerts
	$scope.closeAlert = function(index)
	{
		$scope.alerts.splice(index, 1);
	};
	
	//Sign player in.  Gets a player session.
	this.sign_in = function()
	{
		playerFactory.playerLogin($scope.sign_in)
		.then(
			function(result)
			{
				$scope.player = result;

				$scope.signed_in = true;
				$scope.stage = "characterselect";

                //Get a list of players PCs
                playerFactory.getPlayerPcs($scope.player.id)
                .then(function(result)
                {
                    //Assign the list of PCs to $scope.pcs
                    $scope.pcs = result;
                });
			});

		return;
	};
	
	//Enter Edit Player Mode
	$scope.editPlayer = function()
	{
		$scope.stage = "editplayer";
	};
	
	//Saves player updates
	$scope.saveEditPlayer = function()
	{
		playerFactory.editAuthor($scope.player.user_id, $scope.player_edit)
		.then(function(result)
		{
			console.log("Update Successful");
			$scope.player = result;
			$scope.stage = "characterselect";
		},
		function()
		{
			console.log("update Failed");
		});
	};
	
	//Cancel edit without saving and return to Character Select screen
	$scope.cancelEditPlayer = function()
	{
		$scope.stage = "characterselect";
	};
	
	//Create a new Character stage
	$scope.newCharacter = function()
	{
		$scope.stage = "charactercreate-1";
		
		//Initialize career_skill_choices and specialization_skill_choices
		$scope.career_skill_choices = 4;
		$scope.specialization_skill_choices = 2;
		
		//Initialize the $scope.character MODEL
		$scope.character = {};

		//Get list of races
		playerFactory.getRacesList()
		.then(function(result)
		{
			//Load the results into $scope.races
			$scope.races = result;
			//Set the initial SELECT value
			$scope.character.race = $scope.races[0];
		});
		
		//Get list of careers
		playerFactory.getCareersList()
		.then(function(result)
		{
			//Load the results into $scope.careers
			$scope.careers = result;
			//Set the initial SELECT value
			$scope.character.career = $scope.careers[0];
			
			//Load the career specializations
			playerFactory.getCareerSpecializations($scope.character.career.id)
			.then(function(result)
			{
				$scope.specializations = result;
				$scope.specialization = $scope.specializations[0];
			});
		});
		
		
	};
	
	$scope.setDice = function(len)
	{
			for (var i = 0; i < len; i++)
			{
				$scope.character.skills[i].dice = new Array;
				
				//Attribute is greater than rank
				var attrib = $scope.character.skills[i].attrib;
				
				switch(attrib)
				{
					case "Agility":
						if ($scope.character.agility >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.agility - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.agility; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.agility; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
						
					case "Brawn":
						if ($scope.character.brawn >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.brawn - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.brawn; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.brawn; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
						
					case "Cunning":
						if ($scope.character.cunning >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.cunning - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.cunning; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.cunning; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
						
					case "Intellect":
						if ($scope.character.intellect >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.intellect - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.intellect; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.intellect; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
						
					case "Presence":
						if ($scope.character.presence >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.presence - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.presence; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.presence; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
						
					case "Willpower":
						if ($scope.character.willpower >= $scope.character.skills[i].rank)
						{
							for(var j=0; j<$scope.character.skills[i].rank; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.willpower - $scope.character.skills[i].rank; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						else
						{
							for(var j=0; j<$scope.character.willpower; j++)
							{
								$scope.character.skills[i].dice.push({die: "Proficient.png"});
							}
							
							for(var h=0; h<$scope.character.skills[i].rank - $scope.character.willpower; h++)
							{
								$scope.character.skills[i].dice.push({die: "Standard.png"});
							}
						}
						break;
				}
			}
			return 1;
	};
	
	$scope.selectCharacter = function(index)
	{
		//Set the body to character
		$scope.$root.body_id = "character";
		
		//Set the selected Character
		$scope.character = $scope.pcs[index];
        
		//Get the selected Characters skills
		playerFactory.getPcSkills($scope.character.id)
		.then(function(result)
		{
			//$scope.skills = result;
			
			//$scope.setDice(result.length);
            $scope.setDice($scope.character.skills.length);
		});
		

		//Get the selectec Character weapons
		playerFactory.getPcWeapons($scope.character.id)
		.then(function(result)
		{
			//$scope.weapons = result;
		});

		//Get the selected Character armor
		playerFactory.getPcArmor($scope.character.id)
		.then(function(result)
		{
			console.log(result);
			//$scope.armor = result;
		});

		//Get the selected Character items
		//playerFactory.getPcItems($scope.character.id)
		//.then(function(result)
		//{
		//	$scope.items = result;
		//});

		//Set the stage to the character
		$scope.stage = "characterselected";
		
		//Set initail character_stage
		$scope.character_stage = "overview";
		
		//Start update timer to auto update - 5 second interval
		tmr_attr_update = $interval(function()
		{
			playerFactory.getPc($scope.character.id)
			.then(function(result)
			{
                //Update the player
				$scope.character = result;
                //Redraw the dice
                $scope.setDice($scope.character.skills.length);
			});
		}
		,5000);
	};
	
	
	$scope.$on('destroy', function()
	{
		//Called on 'destroy'.  Stop tmr_attr_update
		if(angular.isDefined(tmr_attr_update))
		{
			$interval.cancel(tmr_attr_update);
			tmr_attr_update = undefined;
		}
		
		//Stop tmr_skills_update
		if(angular.isDefined(tmr_skills_update))
		{
			$interval.cancel(tmr_skills_update);
			tmr_skills_update = undefined;
		}
	});
	
	$scope.characterStage2 = function()
	{
		playerFactory.newPc($scope.player, $scope.character)
		.then(function(result)
		{
			//Saved.  Get new character data with inialized stats
			//Save the race for later testing
			var race = $scope.character.race;
			
			//Save the specialization for later use
			var spec = $scope.specialization;

			$scope.character = result;
			
			//Set the initial Specialization. Uses no xp
			
			playerFactory.setSpecialization($scope.character.id, $scope.specialization.id, "false")
			.then(function(result)
			{
				console.log(result.msg);
			}
			,
			function(result)
			{
				$scope.alerts.push({msg: "Fatal Error", type: "danger"});
			});

			//Get the list of Career Skills for selecting Initial Ranks
			playerFactory.getPcCareerSkills($scope.character.id)
			.then(function(result)
			{
				$scope.skills = result;
				
				//Get the list of specialization career skills
				playerFactory.getSpecializationCareerSkills(spec.id)
				.then(function(result)
				{
					console.log(result);
					$scope.spec_skills = result;
				});

				//Test for Human class
				if(race.name == "Human")
				{
					//Human race.  No bonus skill, but they get a bonus specialization
					$scope.stage = "charactercreate-human";
					
					//Get ALL specializations now.  Bonus can be any.
					playerFactory.getAllSpecializations()
					.then(function(result)
					{
						//Filter out previously select specialization to avoid duplicates
						$scope.specializations = $filter('filter')(result, {name: "!" + spec.name});
						$scope.character.bonus_specialization = $scope.specializations[0];
					});
				}
				else
				{
					$scope.stage = "charactercreate-2";
				}
			});
		});
	};
	
	$scope.characterStage3 = function()
	{
		//XP stage.  Reload data
		$scope.stage = "charactercreate-3";
		
		//Refresh PC skills
		playerFactory.getPcSkills($scope.character.id)
		.then(function(result)
		{
			$scope.skills = result;
		});
	};

	$scope.characterFinished = function()
	{
		//Character creation finished.  Set stage as characterSelected and show final character sheet and
		//set character status = active
		playerFactory.setPcStatus($scope.character.id, "active")
		.then(function(result)
		{
			$scope.character.status = "active";
			$scope.stage = "characterselect";
			playerFactory.getPlayerPcs($scope.player.id)
			.then(function(result)
			{
				$scope.pcs = result;
			});
		});
	};
	
	$scope.saveBonusSpecialization = function()
	{
		//Save the bonus specialiation for the human race
		playerFactory.setSpecialization($scope.character.id, $scope.bonus_specialization.id, "false")
		.then(function(result)
		{
			$scope.stage = "charactercreate-2";
		}
		,
		function(result)
		{
			$scope.alerts.push({msg: result, type: "danger"});
		});
	};
	
	$scope.careerSelected = function()
	{
		//A career has been select.  Reload career specializations
		playerFactory.getCareerSpecializations($scope.character.career.id)
		.then(function(result)
		{
			$scope.specializations = result;
			$scope.specialization = $scope.specializations[0];
		});
	};
	
	$scope.increaseRank = function(skill_id, use_xp)
	{
		playerFactory.increaseRank($scope.character.id, skill_id, use_xp)
		.then(function(result)
		{
			playerFactory.getPcSkills($scope.character.id)
			.then(function(result)
			{
				$scope.skills = result;
			});
			
			playerFactory.getPcXp($scope.character.id)
			.then(function(result)
			{
				$scope.character.xp = result.xp;
			});
		});
	};
	
	$scope.increaseAttribute = function(attribute)
	{
		playerFactory.increaseAttribute($scope.character.id, attribute)
		.then(function(result)
		{
			//Successful increase in attribute.  Reload character.
			playerFactory.getPc($scope.character.id)
			.then(function(result)
			{
				console.log(result);
				$scope.character = result;
			});
		});
	};
	
	$scope.increaseRankCareerInit = function(index, skill_id, use_xp)
	{
			playerFactory.increaseRank($scope.character.id, skill_id, use_xp)
			.then(function(result)
			{
				$scope.career_skill_choices = $scope.career_skill_choices - 1;
				//$scope.alerts.push({msg: "Skill rank increased", type: "success"});
				$scope.skills.splice(index, 1);
			}
			,
			function(result)
			{
				$scope.alerts.push({msg: "Error: " + result.status, type: "danger"});
				console.log("Error: " + result.status);
			});
	};
	
	$scope.increaseRankCareerInit2 = function(index, skill_id, use_xp)
	{
		playerFactory.increaseRank($scope.character.id, skill_id, use_xp)
		.then(function(result)
		{
			$scope.specialization_skill_choices = $scope.specialization_skill_choices - 1;
			$scope.spec_skills.splice(index, 1);
		});
	};
	
	//Cancel create a new character.  Return to character select
	$scope.cancelNewCharacter = function()
	{
		$scope.stage = "characterselect";
	};
	
	$scope.set_char_stage = function(state)
	{
		$scope.character_stage = state;
	};
}]);
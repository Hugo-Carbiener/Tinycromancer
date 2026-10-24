extends Node

var souls : int
var level_number : int = 1
var troops : Dictionary[TroopFactory.ROLES, int] = {
	TroopFactory.ROLES.BASE_TROOP : 15,
	TroopFactory.ROLES.ARCHER : 2
	}

extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resources = ["Nourriture"]

var buildings = []

var nouTot=100

var hab = 3
var habMax = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	buildings.push_back(Home.new("Hutte", 3) )
	buildings.push_back(Building.new("Ferme") )
	pass # Replace with function body.
	
func eat():
	nouTot -= 3*hab
	
func dwell_add(i:int):
	hab += i
	
func dwell_free()->int:
	return habMax-hab
	
func dwell_addMax(i:int):
	habMax+=i

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

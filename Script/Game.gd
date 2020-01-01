extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nouTot=100

var hab = 5

var resources = ["Nourriture"]

var buildings = []

var build_adds:PoolByteArray

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hbox_Nou/NouTot.text = str(nouTot)
	
	$Hbox_Hab/Hab.text = str(hab)
	
	buildings.push_back(Factory.new("Ferme", 0, 3, 1, 1) )

	build_adds.push_back(0)
	
	$ItemList.add_item(buildings[0].name)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NouvTour_button_down():
	nouTot -= 3*hab
	
	$Hbox_Nou/NouTot.text = str(nouTot)
	
	pass # Replace with function body.


func _on_BtnAdd_button_down():
	var index = $ItemList.get_selected_items()[0]
	
	build_adds[index] += 1
	
	$ItemList2.add_item(buildings[index].name + " x" + str(build_adds[index]) )
	
	pass # Replace with function body.

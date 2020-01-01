extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nouTot=100

var hab = 5

var resources = ["Nourriture"]

var buildings = []

var build_adds:Dictionary

var build_ups:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hbox_Nou/NouTot.text = str(nouTot)
	
	$Hbox_Hab/Hab.text = str(hab)
	
	buildings.push_back(Building.new("Ferme") )
	buildings.push_back(Building.new("Hutte") )
	
	for building in buildings:
		$ItemList.add_item(building.name)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NouvTour_button_down():
	nouTot -= 3*hab
	
	$Hbox_Nou/NouTot.text = str(nouTot)
	
	$ItemList2.clear()
	
	for key in build_adds:
		if build_ups.has(key):
			build_ups[key][1] += build_adds[key][1]
			
			$ItemList3.set_item_text(build_ups[key][0], key + " x" + str(build_ups[key][1]) )
		else:
			build_ups[key]=[$ItemList3.get_item_count(), build_adds[key][1] ]
			
			$ItemList3.add_item(key + " x" + str(build_ups[key][1]) )

	build_adds.clear()
	
	pass # Replace with function body.

func _on_BtnAdd_button_down():
	var index = $ItemList.get_selected_items()[0]
	var key = buildings[index].name
	
	if build_adds.has(key):
		build_adds[key][1] += 1
		
		$ItemList2.set_item_text(build_adds[key][0], key + " x" + str(build_adds[key][1]) )
	else:
		build_adds[key]=[$ItemList2.get_item_count(), 1]
		
		$ItemList2.add_item(key + " x1")
	
	pass # Replace with function body.


func _on_BtnCel_button_down():
	var index = $ItemList.get_selected_items()[0]
	var key = buildings[index].name
	
	if build_adds[key][1] == 1:
		$ItemList2.remove_item(build_adds[key][0])
		
		build_adds.erase(key)
	else:
		build_adds[key][1] -= 1
		
		$ItemList2.set_item_text(build_adds[key][0], key + " x" + str(build_adds[key][1]) )
	pass # Replace with function body.

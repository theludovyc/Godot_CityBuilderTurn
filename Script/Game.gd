extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var build_adds:Dictionary

var build_ups:Dictionary

var habAdd = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hbox_Nou/NouTot.text = str(MG.nouTot)
	
	$Hbox_Hab/Hab.text = str(MG.hab)
	$Hbox_Hab/HabMax.text = str(MG.habMax)
	
	build_ups[MG.buildings[0].name]=[0, 1]
	$ItemList3.add_item(MG.buildings[0].name + " x1")
	
	for building in MG.buildings:
		$ItemList.add_item(building.name)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func resetHabAdd():
	if habAdd > 0:
		$Hbox_Hab/HabAdd.text = "+" + str(habAdd)
		$Hbox_Hab/HabAdd.set("custom_colors/font_color", Color(0, 1, 0) )
		return
	else:
		$Hbox_Hab/HabAdd.text = str(habAdd)
		if habAdd == 0:
			$Hbox_Hab/HabAdd.set("custom_colors/font_color", Color(1, 1, 1) )
			return
		else:
			$Hbox_Hab/HabAdd.set("custom_colors/font_color", Color(1, 0, 0) )
			return

func _on_NouvTour_button_down():
	MG.eat()
	
	$Hbox_Nou/NouTot.text = str(MG.nouTot)
	
	MG.dwell_add(habAdd)
	
	habAdd=0
	
	resetHabAdd()
	
	$Hbox_Hab/Hab.text = str(MG.hab)
	
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
	var key = MG.buildings[index].name
	
	if build_adds.has(key):
		build_adds[key][1] += 1
		
		$ItemList2.set_item_text(build_adds[key][0], key + " x" + str(build_adds[key][1]) )
	else:
		build_adds[key]=[$ItemList2.get_item_count(), 1]
		
		$ItemList2.add_item(key + " x1")
	
	pass # Replace with function body.


func _on_BtnCel_button_down():
	var index = $ItemList.get_selected_items()[0]
	var key = MG.buildings[index].name
	
	if build_adds[key][1] == 1:
		$ItemList2.remove_item(build_adds[key][0])
		
		build_adds.erase(key)
	else:
		build_adds[key][1] -= 1
		
		$ItemList2.set_item_text(build_adds[key][0], key + " x" + str(build_adds[key][1]) )
	pass # Replace with function body.

func _on_BtnHabAdd_button_down():
	if habAdd < MG.dwell_free():
		habAdd += 1
		resetHabAdd()
	pass # Replace with function body.


func _on_BtnHabRem_button_down():
	if habAdd > -MG.hab:
		habAdd -= 1
		resetHabAdd()
	pass # Replace with function body.

extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var build_alls:Dictionary

var build_adds:Dictionary

var build_ups

var habAdd = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hbox_Nou/NouTot.text = str(MG.nouTot)
	
	$Hbox_Hab/Hab.text = str(MG.hab)
	$Hbox_Hab/HabMax.text = str(MG.habMax)
	
#	var root = $Tree.create_item()
	
	var prods = $Tree.create_item()
	prods.set_text(0, "Production")
	prods.set_selectable(0, false)
	
	var homes = $Tree.create_item()
	homes.set_text(0, "Habitations")
	homes.set_selectable(0, false)
	
	var others = $Tree.create_item()
	others.set_text(0, "Autres")
	others.set_selectable(0, false)
	
	for building in MG.buildings:
		var b:TreeItem

		match building.type:
			2:
				b = $Tree.create_item(homes)
			_:
				b = $Tree.create_item(others)

		b.set_text(0, building.name)
		
		b.set_text(1, "x0")
		
		build_alls[building.name] = [building, b, 0]
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
	
	for key in build_adds:
		var t = build_alls[key]
		
		var i = build_adds[key]
		
		t[2] += i
		
		t[1].set_text(1, "x" + str(t[2]))
		
		t[1].set_text(2, "")
		
		t[0].onUp(i)
		
		match(t[0].type):
			2:
				$Hbox_Hab/HabMax.text = str(MG.habMax)
		
	build_adds.clear()
	
	pass # Replace with function body.

func resetTreeItem(item:TreeItem, i:int):
	if i>0:
		item.set_text(2, "+" + str(i) )
		item.set_custom_color(2, Color(0, 0.8, 0))
		return
	item.set_text(2, str(i) )
	item.set_custom_color(2, Color(0.8, 0, 0))
	pass

func _on_BtnAdd_button_down():
	var item = $Tree.get_selected()
	
	var key = item.get_text(0)
	
	if build_adds.has(key):
		build_adds[key] += 1
		
		if build_adds[key] == 0:
			build_adds.erase(key)
			
			item.set_text(2, "")
			return
	else:
		build_adds[key] = 1
	
	resetTreeItem(item, build_adds[key])
	pass

func _on_BtnCel_button_down():
	var item = $Tree.get_selected()
	
	var key = item.get_text(0)
	
	if build_adds.has(key):
		if build_adds[key] > -build_alls[key][2]:
			build_adds[key] -= 1
			
			if build_adds[key] == 0:
				build_adds.erase(key)
				
				item.set_text(2, "")
				return
		
			resetTreeItem(item, build_adds[key])
	elif build_alls[key][2] > 0:
		build_adds[key] = -1
		
		resetTreeItem(item, -1)
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

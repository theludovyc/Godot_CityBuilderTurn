class_name Home

extends Building

var myHab:int

func _init(s:String, i:int).(s):
	type = 2
	myHab=i

func onUp(i:int):
	MG.dwell_addMax(myHab*i)
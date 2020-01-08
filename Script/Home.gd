class_name Home

extends Building

var myHab:int

func _init(s:String, i:int).(s):
	myHab=i

func onUp():
	MG.dwell_addMax(myHab)
extends Node

var mute = false

func set_mute(new_mute):
	self.mute = new_mute
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_index, self.mute)

func victory():
	$EffectVictory.play()

func loss():
	$EffectLoss.play()

extends HSlider

@export var audio_bus_name: String

var audio_id

func _ready():
	audio_id = AudioServer.get_bus_index(audio_bus_name)

func _process(delta):
	pass

func _on_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_id, db)

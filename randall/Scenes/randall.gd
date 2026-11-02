extends Node2D

#animation
@onready var anim = $RandallSprite

#movement and positioning parameters
var speed = 300
var CurrentDir = Vector2(1,0)
var gravity = Vector2(0,1)
var screensize = Vector2()
var WindowSize = Vector2(200,200)
var idletime = 0
var idle = false
func savepos(position):
	var file = FileAccess.open("res://Position.txt", FileAccess.WRITE)
	file.store_string(str(position))

func idling():
	if randf() <0.3:
		idle = true
		idletime = randf_range(1.0, 3.0)
		var r = randi() % 3
		if r==0:
			$RandallSprite.play("BlinkStationary")
			speed = 0
		pass


func _ready():
	screensize = Vector2(DisplayServer.screen_get_size())
	anim.play("Walk")
	
func _physics_process(delta: float) -> void:
	if idle:
		idletime -= delta
		if idletime <= 0:
			idle = false
			speed = 150
			$RandallSprite.play("Walk")
		return
	var CurrentPos = Vector2(DisplayServer.window_get_position())
	savepos(CurrentPos)
	#CurrentPos += gravity * speed*delta
	CurrentPos += CurrentDir * speed * delta
	
	
	CurrentPos.x = clamp(CurrentPos.x, 0,screensize.x - WindowSize.x)
	CurrentPos.y = clamp(CurrentPos.y, 0,screensize.y - WindowSize.y)
	DisplayServer.window_set_position(Vector2i(CurrentPos))
	if CurrentPos.x <= 0 or CurrentPos.x >= screensize.x - WindowSize.x:
		CurrentDir.x *= -1
		idling()
	if CurrentPos.y <= 0 or CurrentPos.y >= screensize.y - WindowSize.y:
		CurrentDir.y *= -1
		idling()

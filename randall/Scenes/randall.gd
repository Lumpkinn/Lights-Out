extends Node2D

#animation and interaction
@onready var anim = $RandallSprite
@onready var randallArea = $Area2D
var is_dragging = false
var dragOffset = Vector2()

#movement and positioning parameters
var speed = 150
var CurrentDir = Vector2(1,0)
var gravity = Vector2(0,1)
var screensize = Vector2()
var WindowSize = Vector2(200,200)
var idletime = 0
var idle = false

#Stores randall's position for the light
func savepos(position):
    var file = FileAccess.open("res://Position.txt", FileAccess.WRITE)
    file.store_string(str(position))

#makes randall wait every once in a while
func idling():
    if randf() <0.3:
        idle = true
        idletime = randf_range(1.0, 6.0)
        var r = randi() % 3
        if r == 0:
            $RandallSprite.play("BlinkStationary")
            speed = 0
        print("Taking a break")
        pass
#function that runs whenever you drag randall
func OnDrag(_viewport, event, _shape_idx):
     print("Check 1")   
     if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
            
            if event.pressed:
                print("Check 2")
                is_dragging = true
                var mouse_pos = Vector2(DisplayServer.mouse_get_position())
                var win_pos = Vector2(DisplayServer.window_get_position())
                dragOffset = mouse_pos - win_pos
                print("put me down")
            else:
                is_dragging = false
                print("Thats better")

func _ready():
    screensize = Vector2(DisplayServer.screen_get_size())
    anim.play("Walk")
    randallArea.input_event.connect(OnDrag)

func _physics_process(delta: float) -> void:
    if is_dragging:
        var mouse_pos = Vector2(DisplayServer.mouse_get_position())
        var new_win_pos = mouse_pos - dragOffset
        DisplayServer.window_set_position(Vector2i(new_win_pos))
    if idle:
        idletime -= delta
        if idletime <= 0:
            idle = false
            speed = 0
            $RandallSprite.play("Walk")
        
    var CurrentPos = Vector2(DisplayServer.window_get_position())
    savepos(CurrentPos)
    #make him fall
    CurrentPos += gravity * 300 * delta
    if CurrentPos.y < 830:
        speed = 0
    else:
        speed = 150
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

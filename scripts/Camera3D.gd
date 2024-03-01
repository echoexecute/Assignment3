extends Camera3D

var rotation_speed = 0.005
var Pivoty
var Pivotx 
var Knight
var collisionshape

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Pivoty = $"../.."
	Pivotx = $".."
	Knight = $"../../../Knight"
	collisionshape = $"../../../CollisionShape3D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseMotion:
		Pivoty.rotate_y(-event.relative.x * rotation_speed)
		Knight.rotate_y(-event.relative.x * rotation_speed)
		collisionshape.rotate_y(-event.relative.x * rotation_speed)
		var new_pitch = Pivoty.rotation.x - -event.relative.y * rotation_speed
		Pivotx.rotate_x(new_pitch)

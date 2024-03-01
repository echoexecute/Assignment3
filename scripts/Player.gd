extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var playback

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	playback = $AnimationTree.get("parameters/playback")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector3.ZERO
	direction.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	direction.z = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var attack = Input.get_action_strength("ui_select")
	direction = direction.rotated(Vector3.UP,$Knight.rotation.y)
	if direction:
		playback.travel("Walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if attack:
			playback.travel("Attack")
			velocity.x = 0
			velocity.z = 0
	else:
		playback.travel("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if attack:
			playback.travel("Attack")
			velocity.x = 0
			velocity.z = 0

	move_and_slide()


func _on_hitbox_body_entered(body):
	if body.name == "Minion":
		body.takedamage()


func _on_hitbox_body_exited(body):
	pass # Replace with function body.

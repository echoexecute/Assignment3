extends CharacterBody3D


enum States{ATTACK,CHASE,IDLE}
var currentstate = States.IDLE
@export var speed = 2
var playback
var player
var health = 100

func _ready():
	playback = $AnimationTree.get("parameters/playback")
	player = get_node("/root/World/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()
	velocity = Vector3.ZERO
	if currentstate == States.CHASE:
		playback.travel("Walk")
		look_at(player.rotation)
		var direction_vec = (player.position - position).normalized()
		velocity = direction_vec * speed
	elif currentstate == States.ATTACK:
		playback.travel("Attack")
		velocity = Vector3.ZERO
	elif currentstate == States.IDLE:
		playback.travel("Idle")
	
	move_and_slide()


func takedamage():
	health -= 25

func _on_detection_sphere_body_entered(body):
	if body.name == "Player":
		currentstate = States.CHASE


func _on_detection_sphere_body_exited(body):
	if body.name == "Player":
		currentstate = States.IDLE


func _on_attack_sphere_body_entered(body):
	if body.name == "Player":
		currentstate = States.ATTACK


func _on_attack_sphere_body_exited(body):
	if body.name == "Player":
		currentstate = States.CHASE

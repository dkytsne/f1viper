extends CharacterBody2D

var maxSpeed = 300.0
var acceleration = 50.0
var rotationSpeed = 1.0

func _physics_process(delta):
	if velocity.length() > maxSpeed:
		velocity = velocity.normalized() * maxSpeed
		
	if Input.is_action_pressed("W"):
		velocity += Vector2(0, -1).rotated(rotation) * acceleration * delta
		
	elif abs(velocity) > Vector2.ZERO:
		if Input.is_action_pressed("S"): 
			velocity = lerp(velocity, Vector2.ZERO, delta)
		velocity = velocity.move_toward(Vector2.ZERO, 20 * delta)
		
	var horDir = Input.get_axis("A", "D")
	
	if horDir:
		var effectiveRotationSpeed = (1 - (velocity.length() / maxSpeed)) * rotationSpeed
		rotation += horDir * effectiveRotationSpeed * delta * 2

	move_and_slide()


func onOffroadBodyEntered(body: Node2D):
	acceleration = 12.5
	maxSpeed = 75.0


func onOffroadBodyExited(body: Node2D):
	acceleration = 50.0
	maxSpeed = 300.0


func onFinishLineBodyEntered(body: Node2D):
	if body.has_method("lapEnd"):
		body.lapEnd()

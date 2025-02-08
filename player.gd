extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
var gravity = 2000  # Gravity strength


var respawn_position = Vector2(500, 270)


func _physics_process(delta):
	# Apply gravity if not on the ground
	if not is_on_floor():
		velocity.y += gravity * delta

	# Use UI actions instead of custom ones
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED  # Move left/right

	# Jump with "ui_accept" (Enter, Space, or A on a controller)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Check if the player falls off the map
	if position.y > 2000:  # Adjust this value based on your level height
		reset_position()

	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = respawn_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func reset_position():
	position = respawn_position
	velocity = Vector2.ZERO  # Stop movement when respawning

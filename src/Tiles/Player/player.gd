# Setup class type
extends "res://SpriteShading/SpriteShadedSpacial.gd"
const rb_texture = preload("sphere_sprite.png")
const lb_texture = preload("sphere_sprite.png")
const lf_texture = preload("sphere_sprite.png")
const rf_texture = preload("sphere_sprite.png")

var body : KinematicBody
func _init():
	var _self = self
	body = _self

# Setup vars
var orig = Vector3()
const GRAVITY = 0.98
const JUMP_FORCE = 20
var fall_speed = 0

const SPEED = 8

const l_vec = Vector3(-1,0,1)
const r_vec = Vector3(1,0,-1)
const u_vec = Vector3(-1,-0,-1)
const d_vec = Vector3(1,0,1)

var velocity = Vector3(0,0,0)
func _ready():
	pass

func _physics_process(delta):
	velocity = Vector3()
	
	if Input.is_action_pressed("ui_left"):
		velocity += l_vec
	if Input.is_action_pressed("ui_right"):
		velocity += r_vec
	if Input.is_action_pressed("ui_up"):
		velocity += u_vec
	if Input.is_action_pressed("ui_down"):
		velocity += d_vec
	velocity = SPEED * velocity.normalized()
	
	if fall_speed < -6*GRAVITY: # can't move while falling
		velocity = Vector3()
	
	velocity.y = fall_speed
	body.move_and_slide(velocity, Vector3(0,1,0))
	
	fall_speed -= GRAVITY
	
	var grounded = body.is_on_floor()
	if grounded and fall_speed <=0:
		fall_speed = -0.1
	
	var just_jumped = false
	#if grounded and Input.is_action_pressed("ui_jump"):
	#	just_jumped = true
	#	fall_speed = JUMP_FORCE
	
	if self.transform.origin.y < -20:
		#self.position(orig)
		get_tree().get_current_scene().finish_line()

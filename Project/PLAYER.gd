extends KinematicBody

#Player Statuses
var hsp = 0
var vsp = 0

var dirX = 1
var dirY = 1
var jumpTime = 0

#Constants
const ACCELERATION = 0.80
const FRICTION = 0.8
const GRAVITY = 0.35
const TOPXSPEED = 8

#Character Exclusive
enum ROSTER {CHENDA, JESS ,NATAN, MELGAS}

var CHARA = ROSTER.JESS

var jessTeleLength = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#TODO: port gms code to here
func _physics_process(_delta):
	var move_vec = Vector3()
	
	var moveX = (1 if Input.is_action_pressed("actionright") else 0) - (1 if Input.is_action_pressed("actionleft") else 0);
	var moveY = (1 if Input.is_action_pressed("actionup") else 0) - (1 if Input.is_action_pressed("actiondown") else 0);
	
	if moveX != 0: dirX = sign(moveX)
	if moveY != 0: dirY = sign(moveY)
	
	hsp = clamp(hsp,-TOPXSPEED,TOPXSPEED)
	
	match abs(moveX):
		float(0): 
			if abs(hsp) > 0: 
				hsp -= FRICTION*sign(hsp) 
			if abs(hsp) <= FRICTION: 
				hsp = 0
		float(1):
			if abs(hsp) >= 0: hsp += ACCELERATION*dirX
	
	match CHARA:
		ROSTER.JESS:
			if Input.is_action_pressed("action2"): 
				if jessTeleLength > 0:
					hsp = moveX*20
					vsp = moveY*20
					jessTeleLength -= 0.1
			else: jessTeleLength = 2
		ROSTER.MELGAS:
			pass #write gun code
		ROSTER.NATAN:
			pass #write bat swing code. you get the drill lol

	if !is_on_floor():
		vsp -= GRAVITY
		if !is_on_ceiling():
			if Input.is_action_pressed("action1"): 
				jumpTime += 1
				if (jumpTime < 20): vsp = 10
			else: jumpTime = 20
	elif !is_on_ceiling():
		vsp = 0
		jumpTime = 0
		if Input.is_action_just_pressed("action1"):
			#play sound
			vsp = 6
	else:
		vsp = 0
		
	move_vec.x = hsp
	move_vec.y = vsp
	move_vec.z = 0
# warning-ignore:return_value_discarded
	move_and_slide(move_vec, Vector3(0,1,0))

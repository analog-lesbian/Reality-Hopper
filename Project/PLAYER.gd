#HEY HEY HEY LOOK LOOK
#KEEP LOOKING IF YOURE COMING BACK AFTER SAGE
#PLEASE DONT IGNORE
#OPTIMIZE THE *FUCK* OUT OF THIS CODE WHEN YOU COME BACK!!!!!! ITS BERY IMPORTANT

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

#Realities
enum MODE {RELAXED, PULSE}
var REALITY = 0

#Character Exclusive
enum ROSTER {CHENDA, JESS ,NATAN, MELGAS}
var CHARA = ROSTER.JESS

var jessTeleLength = 0

#TODO: port gms code to here
var TIME = 359940
	
func _physics_process(_delta):
#////////////////////////////////////Movement Setup/////////////////////////////////////
	var move_vec = Vector3()
	
	var moveX = (1 if Input.is_action_pressed("actionright") else 0) - (1 if Input.is_action_pressed("actionleft") else 0);
	var moveY = (1 if Input.is_action_pressed("actionup") else 0) - (1 if Input.is_action_pressed("actiondown") else 0);
	
	if moveX != 0: dirX = sign(moveX)
	if moveY != 0: dirY = sign(moveY)
	
	hsp = clamp(hsp,-TOPXSPEED,TOPXSPEED)
#////////////////////////////////////Movement Setup/////////////////////////////////////
	
#/////////////////////////////////Reality Switching Code////////////////////////////////
	if Input.is_action_just_pressed("modeswitch"): 
		REALITY += 1
		get_node("REALITY_TRANSITION/FADE").show()
		get_node("REALITY_TRANSITION/ANIM").play("fade")
	REALITY = REALITY%2
	
	set_collision_mask_bit(1,!REALITY)
	set_collision_mask_bit(2,REALITY)
	
	if get_node_or_null("/root/Spatial/RELAXED"):
		get_node("/root/Spatial/RELAXED").call("show" if !REALITY else "hide")
	if get_node_or_null("/root/Spatial/PULSE"):
		get_node("/root/Spatial/PULSE").call("show" if REALITY else "hide")
	
	get_node("REALITY_HUD").call("show" if !REALITY else "hide")
	get_node("PULSE_HUD").call("show" if REALITY else "hide")
#/////////////////////////////////Reality Switching Code////////////////////////////////
	
	
	if get_node("cast").is_colliding():
		var n = get_node("cast").get_collision_normal()
		var slope_angle = (rad2deg(acos(n.dot(Vector3(0,-1,0)))) -180)*-1
		
	print(str(TIME/3600).pad_zeros(2),":",str((TIME/60)%60).pad_zeros(2),":",str((TIME)%60).pad_zeros(2))
	if Input.is_action_just_pressed("debug3"): TIME += 600
	TIME -= 1
	
	
	
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
	move_vec.z = (1 if Input.is_action_pressed("debug1") else 0) - (1 if Input.is_action_pressed("debug2") else 0)*2;
# warning-ignore:return_value_discarded
	move_and_slide(move_vec, Vector3(0,1,0))

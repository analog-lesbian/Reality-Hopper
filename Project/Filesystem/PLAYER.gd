extends KinematicBody

#Player Statuses
var hsp = 0
var vsp = 0

var dirX = 1
var dirY = 1
var jumpTime = 0
var degreetest = 90

var REALITY = 0

#Constants
const ACCELERATION = 0.80
const FRICTION = 0.8
const GRAVITY = 0.35
const TOPXSPEED = 8

#Modifiers
var moveableX = true
var moveableY = true
var grvintensity = 1

#Character Exclusive
enum ROSTER {CHENDA, JESS ,NATAN, MELGAS}
var CHARA = ROSTER.JESS

var JESSTELELENGTH = 0

var TIME = 3600 #359940 is maximum!

func _physics_process(_delta):
#////////////////////////////////////Movement /////////////////////////////////////
	var move_vec = Vector3()
	
	var moveX = (int(Input.is_action_pressed("actionright"))) - (int(Input.is_action_pressed("actionleft")));
	var moveY = (int(Input.is_action_pressed("actionup"))) - (int(Input.is_action_pressed("actiondown")));
	
	if moveX != 0: dirX = sign(moveX)
	if moveY != 0: dirY = sign(moveY)
	
	hsp = clamp(hsp,-TOPXSPEED,TOPXSPEED)
	
	#Horizontal 
	
	match abs(float(moveX && moveableX == true)):
		float(0): 
			if abs(hsp) > 0: hsp -= FRICTION*sign(hsp) 
			if abs(hsp) <= FRICTION: hsp = 0
		float(1):
			if abs(hsp) >= 0: hsp += ACCELERATION*dirX
			
#Vertical 
	vsp -= (GRAVITY*grvintensity)*int(!is_on_floor())
	if moveableY:
		if is_on_floor():
			grvintensity = 0
			jumpTime = 0
			if vsp < 0: vsp = 0
		if !is_on_ceiling():
			if Input.is_action_pressed("action1") and (jumpTime != 20):
				grvintensity = 0
				if jumpTime < 20: jumpTime += 1
				if (jumpTime < 20): vsp = 12
			else: 
				grvintensity = 1.5	
				jumpTime = 20
		else:
			vsp = 0
			jumpTime = 20
	else:
		vsp = 0
		grvintensity = 0
	
#//////////////////////////////////////Character Code/////////////////////////////////////
	#Other characters will not be implemented yet! This is reserved for after the demo.
	match CHARA:
		ROSTER.CHENDA:
			pass
		ROSTER.JESS:
			pass
		ROSTER.MELGAS:
			pass #write gun code
		ROSTER.NATAN:
			pass
#/////////////////////////////////Reality Switching Code////////////////////////////////
	
	if Input.is_action_just_pressed("modeswitch"): 
		REALITY += 1
		get_node("HUD/FADE").show()
		get_node("HUD/ANIM").seek(0)
		get_node("HUD/ANIM").play("fade")
	REALITY = REALITY%2
	
	set_collision_mask_bit(1,!REALITY)
	set_collision_mask_bit(2,REALITY)
	
	get_node("/root/PROPERTIES/RELAXED").call("show" if !REALITY else "hide")
	get_node("/root/PROPERTIES/PULSE").call("show" if REALITY else "hide")
	
	get_node("HUD/REALITY_HUD").call("show" if !REALITY else "hide")
	get_node("HUD/PULSE_HUD").call("show" if REALITY else "hide")

#///////////////////////////////////Time Management Code//////////////////////////////////
	
	#print(str(TIME/3600).pad_zeros(2),":",str((TIME/60)%60).pad_zeros(2),":",str((TIME)%60).pad_zeros(2))
	if Input.is_action_just_pressed("debug3"): TIME += 600
	TIME -= 1
	
#//////////////////////////////////////Miscallaneous Code/////////////////////////////////////
	
	move_vec.x = hsp
	move_vec.y = vsp
	move_vec.z = (int(Input.is_action_pressed("debug9"))) - (int(Input.is_action_pressed("debug0")))*2;
	
	move_and_slide(move_vec, Vector3(0,1,0))
	
	print(vsp)
	
func _damaged():
	moveableX = false
	moveableY = false
	get_node("/root/GLOBAL/DRAW_TOP_PRIORITY").scene_change("reset", 2)

extends CharacterBody2D

# 基础属性
@export var speed := 200
@export var jump_velocity := -400
@export var gravity := 900


func _physics_process(delta):
	# 重力
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# 左右移动
	var input_dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_dir * speed

	# 跳跃
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	# 移动
	move_and_slide()

	# 动画切换
	var anim = "idle"
	if not is_on_floor():
		anim = "jump" if velocity.y < 0 else "fall"
	elif velocity.x != 0:
		anim = "run"
	$AnimatedSprite2D.play(anim)
	# 朝向控制
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

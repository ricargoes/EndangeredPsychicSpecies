extends Node2D

enum {MOVEMENT, TELEKINESIS, GRAB, DROP, FINAL}
var tutorial_phase

var movement_alien_done = false
var movement_carrier_done = false

var text = {MOVEMENT: """
-[Alien] Hold RIGHT MOUSE to move to red marker

-[Richard] Use WASD y SPACE to move to red marker
""",
TELEKINESIS: """
-[Alien] With the LEFT MOUSE click and hold on the marked wheel, drag away and release to move the object with telekinesis. Try to hit Richard doing this.

-[Richard] Stay still so it is easier to hit you.
""",
GRAB: """When Richard gets hit, he is stunned for a brief moment.
-[Alien] Stay still so it is easier to grab you

-[Richard] Go to the alien and grab him pressing E
""",
DROP: """When Richard gets hit while carrying the alien, he will drop him
-[Alien] Try to hit Richard with telekinesis so he drops you

-[Richard] Try to reach the Helicopter
""",
FINAL: """When the alien is dropped
-[Alien] Try to kill yourself by stepping in dangerous places (marked in green)

-[Richard] Try to grab the alien and reach the Helicopter
"""}

func _ready():
	tutorial_phase = MOVEMENT
	update_guidelines()

func _on_MovementAlien_body_entered(body):
	movement_alien_done = true
	$StuffTutorial/MovementAlien.queue_free()
	check_movement_phase()

func _on_MovementCarrier_body_entered(body):
	movement_carrier_done = true
	$StuffTutorial/MovementCarrier.queue_free()
	check_movement_phase()

func check_movement_phase():
	if movement_alien_done and movement_carrier_done:
		tutorial_phase = TELEKINESIS
		update_guidelines()
		$UI/TelekinesisHelp.show()
		$UI/TelekinesisHelp.play("default")
		$Stuff/CarWheel/Wheel/ThrowableMarker.show()
		$Carrier.set_process(false)
		$Carrier/Sprite.stop()
		$Carrier/Walking.stop()

func _on_Carrier_stun():
	$Carrier.set_process(true)
	if tutorial_phase == TELEKINESIS:
		tutorial_phase = GRAB
		update_guidelines()
		$UI/TelekinesisHelp.queue_free()
		$AlienBody.set_process(false)
		$AlienBody/Sprite.stop()
		$StuffTutorial/DestCarAlien.queue_free()
		$Stuff/CarWheel/Wheel.queue_free()
	elif tutorial_phase == DROP:
		tutorial_phase = FINAL
		update_guidelines()

func _on_Carrier_alien_grab():
	if tutorial_phase == GRAB:
		tutorial_phase = DROP
		update_guidelines()
		$StuffTutorial/DestCarHeli.queue_free()

func _on_WaitForHit_body_entered(body):
	if tutorial_phase == DROP:
		$Carrier.set_process(false)
		$Carrier/Walking.stop()
		$Carrier/Sprite.stop()

func update_guidelines():
	$UI/Instructions.text = text[tutorial_phase]
	$UI/Instructions/AnimationPlayer.play("blink")

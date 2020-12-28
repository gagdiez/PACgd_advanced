extends Interactive

func _ready():
	# For the WHITE box, the main_action is (implicitly) "walk_to"
	
	# We have to stand a couple of pixels away from it to interact
	position = self.transform.origin - Vector3(3, 0, 0)
	
	# Description
	description = "The mythical white box!"

func use_item(who, what):
	# The WHITE box will interact with the RED one, since the GREEN is hidden
	who.approach(self)
	who.face_object(self)
	who.say("Time to place one box on top of the other")
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(what)
	who.interact(self, "place_box", [what])
	who.animate_until_finished("lower_hand")
	who.say("Wow, a floating box appeared!")
	
	# Uncomment the next line to make Cole automatically pile the GREEN box
	#who.interact(self, "play_outro")

func place_box(box):
	# Function called by who.interact(self, "place_red_box")
	# Place the box on top of the WHITE one
	box.transform.origin = self.transform.origin + Vector3(0, 2, 0)
	box.position = box.transform.origin - Vector3(3, 0, 0)
	box.visible = true
	box.interactive = true
	
	# Change its main action, so you cannot "use" it anymore
	box.main_action = ACTIONS.walk_to
	
	# The GREEN box appears!
	$"../Green Box".visible = true
	$"../Green Box".interactive = true
	
	# The WHITE box is not interactive anymore
	self.interactive = false

func play_outro(_who):
	# The OUTRO showcases our CutScene system
	$"../../PointClick".play_scene("res://cutscenes/Outro.txt")

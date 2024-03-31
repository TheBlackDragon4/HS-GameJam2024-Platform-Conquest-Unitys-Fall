extends Node

var game_freeze = false

var easter_eggs_found = 0

var crawl_enemy_health = 100

var weapon: InvItem = InvItem.new("Stick", preload("res://icons/dummy/stick.png"), 20)

var player_base_damage = weapon.damage

var crawler_base_damage = 25

var level_completed = [false,false,false,false,false,false,false]

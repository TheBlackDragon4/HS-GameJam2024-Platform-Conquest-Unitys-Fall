extends Node

var game_freeze = false

var easter_eggs_found = 0

var crawl_enemy_health = 100

var weapon: InvItem = InvItem.new("stick", preload("res://icons/dummy/stick.png"), 20)
var inv: Inv = load("res://Inventory/player_inventory.tres")
var craft: Inv = load("res://Inventory/crafting/player_crafting_inventory.tres")

var player_base_damage = weapon.damage

var crawler_base_damage = 25

var level_completed = [false,false,false,false,false,false,false]

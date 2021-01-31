using Godot;
using System;

public class ItemInfo : Node
{
	[Export] public string itemName = "default";
	[Export] public int itemId = -1;
	[Export] public Texture itemIcon = (Texture)GD.Load("res://sprites/default-sprite.png");
	[Export] public string description = "default";


}

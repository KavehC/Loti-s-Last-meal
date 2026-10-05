using Godot;
using System;

public partial class FoodItem : Node2D
{
	[Export] public string Name;
	[Export] public Texture2D Icon;
	[Export] public float Safety; // Currently a value between -3 and 3

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Sprite2D sprite = new Sprite2D();
		sprite.Texture = Icon;
		AddChild(sprite);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}

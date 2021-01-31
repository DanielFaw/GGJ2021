using Godot;
using System;

public class MineableItem : Node
{
	[Export] int amountOfItemsToSpawn = 5;
	[Export] int hardness = 1;
	[Export] int itemIdDropped = 0;
	bool isMining;

	[Signal]
	public delegate void ResourceMined();

	//The amount of time in seconds between resource drops
	[Export] float timeBetweenDrops;
	public async void MineResource(float miningPower)
	{
		isMining = true;

		//Calculate how fast the resource can be mined with a given tool
		
		float miningSpeed = timeBetweenDrops / miningPower;

		//Start mining
		while(isMining && amountOfItemsToSpawn > 0)
		{
			//Pause for *miningSpeed* amount of seconds before spawing resource
			await ToSignal(GetTree().CreateTimer(miningSpeed), "timeout");
			HitItem();
		}

	}
	public void StopMining()
	{
		isMining = false;
	}


	public void HitItem()
	{
		
		amountOfItemsToSpawn--;
		if(amountOfItemsToSpawn > 0)
		{
			//Emit signal to "damage" laser
			EmitSignal(nameof(ResourceMined));
			//Drop item
			GD.Print(Name + " has been mined!");
		}
		else
		{
			//Destroy resource node
		}
	}

	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		if(isMining)
		{

		}
	}
}

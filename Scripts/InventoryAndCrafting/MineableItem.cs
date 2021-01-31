using Godot;
using System;

public class MineableItem : Node
{
	[Export] int amountOfItemsToSpawn = 5;
	[Export] int hardness = 1;
	[Export] int itemIdDropped = 0;
	bool isMining;

	Node miningLaser;

	[Signal]
	public delegate void ResourceMined();

	[Signal]
	public delegate void ResourceDepleted();

	//The amount of time in seconds between resource drops
	[Export] float timeBetweenDrops;
	public async void MineResource(float miningPower,Node laser)
	{
		isMining = true;
		miningLaser = laser;
		//Calculate how fast the resource can be mined with a given tool
		
		float miningSpeed = timeBetweenDrops / miningPower;

		//Start mining
		while(isMining && amountOfItemsToSpawn >= 0)
		{
			//Pause for *miningSpeed* amount of seconds before spawing resource
			await ToSignal(GetTree().CreateTimer(miningSpeed), "timeout");

			//Make sure the player hasn't stopped mining since the timer was created
			if(isMining)
			{
				HitItem();
			}
		}
	}
	public void StopMining()
	{
		isMining = false;
	}


	public async void HitItem()
	{

		if(amountOfItemsToSpawn > 0)
		{
			//Emit signal to "damage" laser
			EmitSignal(nameof(ResourceMined));
			//Drop item
			GD.Print(Name + " has been mined!");

			//TEMPORARY
			PlayerInventory inv = (PlayerInventory)GetNode("/root/PlayerInventory");
			inv.AddItem(1,itemIdDropped);
		}
		else
		{
			miningLaser.Call("ResourceDestroyed");
			EmitSignal(nameof(ResourceDepleted));
			this.Set("visible",false);
			await ToSignal(GetTree().CreateTimer(0.2f), "timeout");

			

			//Destroy resource node
			if(!IsQueuedForDeletion())
			{
				QueueFree();
			}
			
		}
		amountOfItemsToSpawn--;
	}
}

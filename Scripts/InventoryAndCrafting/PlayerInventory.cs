using Godot;
using System;
using System.Collections.Generic;

public class PlayerInventory : Node
{
	Dictionary<int, int> inventory;
	Crafter craftRef;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		inventory = new Dictionary<int, int>();
		craftRef = GetNode("../CrafterScript") as Crafter;
		GD.Print("Inventory working!");
		SetInventory();
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

	private void SetInventory()
	{
		//Add whatever the player starts out with here
	}

	float temp = 0;
	public override void _Process(float delta)
	{
		
		temp += delta;
		if(temp > 3f)
		{
			//Print out a few things
			if(ItemList.Instance.RetrieveItemName(2) == null)
			{
				GD.Print("Item retrieval failed");
				return;
			}
			string one = ItemList.Instance.RetrieveItemName(2);
			string two = ItemList.Instance.RetrieveItemDescription(7);
			string three = ItemList.Instance.RetrieveItemDescription(5);
			if (one == null)
			{
				GD.Print("String1 was null");
			}
			else if (two == null)
			{
				GD.Print("String2= was null");
			}
			else if (three == null)
			{
				GD.Print("String3 was null");
			}
			GD.Print(one);
			GD.Print(two);
			GD.Print(three);
			temp = -1000;
		}
	}

	private void PrintInventory()
	{
		foreach(KeyValuePair<int, int> item in inventory)
		{
			GD.Print("Amount of item " + item.Key + ": " + item.Value);
		}
	}

	public void AddItem(int itemAmount, int itemId)
	{
		if(inventory.ContainsKey(itemId))
		{
			inventory[itemId] += itemAmount;
		}
		else
		{
			inventory.Add(itemId, itemAmount);
		}
	}
	
	public void RemoveItem(int itemId, int itemAmount)
	{
		if(inventory.ContainsKey(itemId))
		{
			inventory[itemId] -= itemAmount;
			if (inventory[itemId] < 1)
			{
				inventory.Remove(itemId);
			}
		}
	}
	
	/// <summary>
	/// Craft the specified item. Returns true if it was successful.
	/// </summary>
	/// <param name="itemId"></param>
	public bool CraftItem(int itemId)
	{
		if(inventory.Count < 1)
		{
			return false;
		}
		//Convert the dictionary into a list
		List<int> convertedInventory = new List<int>();
		foreach(KeyValuePair<int, int> item in inventory)
		{
			convertedInventory.Add(item.Value);
			convertedInventory.Add(item.Key);
		}

		//call the crafter script

		if(craftRef.CheckCrafting(itemId, convertedInventory))
		{
			//Craft dis item!
			List<int> recipe = craftRef.GetRecipe(itemId);
			for(int i = 1; i <= recipe.Count; i+= 2)
			{
				RemoveItem(recipe[i], recipe[i - 1]);
			}
			AddItem(itemId, craftRef.AmountCreated(itemId));
			return true;
		}
		else
		{
			return false;
		}
		
	}
}

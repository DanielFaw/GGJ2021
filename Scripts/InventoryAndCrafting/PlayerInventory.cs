using Godot;
using System;
using System.Collections.Generic;

public class PlayerInventory : Node
{
	Dictionary<int, int> inventory;

	public Dictionary<int,int> Inventory{get =>inventory;}
	Crafter craftRef;

	[Signal]
	public delegate void ItemUpdate(int itemId,int newAmount);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		inventory = new Dictionary<int, int>();
		craftRef = GetNode("/root/Crafter") as Crafter;
		//GD.Print("Inventory working!");
		SetInventory();
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }


	///Returns the amount of a specified item in the players inventory
	public int GetAmountOfItem(int itemId)
	{
		if(inventory.ContainsKey(itemId))
		{
			return inventory[itemId];
		}
		return 0;
	}

	public int InventoryCount()
    {
		return inventory.Count;
    }

	public int[] InvToArray()
    {
		List<int> convertedInv = InvToList();
		int[] data = new int[convertedInv.Count];
		for(int i = 0; i < data.Length; i++)
        {
			data[i] = convertedInv[i];
        }
		return data;
    }

	private void SetInventory()
	{
		//Add whatever the player starts out with here
		AddItem(10, 1);
		AddItem(10,2);
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

		//Update Inventory UI
		EmitSignal(nameof(ItemUpdate),itemId,inventory[itemId]);
	}
	
	public void RemoveItem(int itemId, int itemAmount)
	{
		if(inventory.ContainsKey(itemId))
		{
			inventory[itemId] -= itemAmount;
			if (inventory[itemId] < 1)
			{
				//Update inventory ui
				EmitSignal(nameof(ItemUpdate), itemId, 0);
				inventory.Remove(itemId);
			}
			else
            {
				//Update inventory ui
				EmitSignal(nameof(ItemUpdate), itemId, inventory[itemId]);
			}
			

		}
	}

	public List<int> InvToList()
    {
		List<int> convertedInventory = new List<int>();
		foreach (KeyValuePair<int, int> item in inventory)
		{
			convertedInventory.Add(item.Value);
			convertedInventory.Add(item.Key);
		}
		return convertedInventory;
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

		//Call the crafter script
		if(craftRef.CheckCrafting(itemId, convertedInventory))
		{
			//Craft dis item!
			List<int> recipe = craftRef.GetRecipe(itemId);
			for(int i = 1; i <= recipe.Count; i+= 2)
			{
				RemoveItem(recipe[i], recipe[i - 1]);
			}
			AddItem(craftRef.AmountCreated(itemId),itemId);
			GD.Print("New inventory: ");
			PrintInventory();
			return true;
		}
		else
		{
			return false;
		}
		
	}
}

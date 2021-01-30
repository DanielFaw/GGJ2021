using Godot;
using System;
using System.Collections.Generic;

public class Crafter : Node
{

	//Never address these on their own; only use helper functions to input/output info from them!
	//These have to be dictionaries unless we want to add a null crafting recipe for everything that can't be directly crafted, which would be kinda dumb
	Dictionary<int, List<int>> craftingDict;
	Dictionary<int, int> madePerCraft;
	Dictionary<int, List<int>> recipeDict;

	

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		craftingDict = new Dictionary<int, List<int>>();
		madePerCraft = new Dictionary<int, int>();
		recipeDict = new Dictionary<int, List<int>>();
		InitiateRecipes();
	}
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

	private void InitiateRecipes()
	{
		//Make all of the crafting recipes here
	}




	//The formatted array must be as follows:
		//[amountOfItem, itemID, amountOfItemN, ItemNId]
		//This can go on however long you like, but it must be amount,id even if it is just 1 item/amount
	private void AddRecipe(int IdOfItem, List<int> formattedArray, int amountCreated = 1)
	{
		if(formattedArray.Count % 2 != 0)
		{
			return; //bail out if the array is odd, or else it might crash
		}
		
		craftingDict.Add(IdOfItem, formattedArray);
		madePerCraft.Add(IdOfItem, amountCreated);
		
		//Adds the crafted item as a craftable for all the ingredients, for faster searching later
		for(int i = 1; i <= formattedArray.Count; i+=2)
		{
			if(!recipeDict.ContainsKey(formattedArray[i]))
			{
				//If it doesn't yet exist, just add it like you normally would
				recipeDict.Add(formattedArray[i], new List<int>{IdOfItem});
				//recipeDict[formattedArray[i-1]].Add(IdOfItem);
			}
			else
			{
				//otherwise, append the list
				recipeDict[formattedArray[i]].Add(IdOfItem);
			}
			
		}
	}

	public List<int> GetRecipe(int itemId)
	{
		if(craftingDict.ContainsKey(itemId))
		{
			return craftingDict[itemId];
		}
		else
		{
			return null;
		}
	}

	public int AmountCreated(int itemId)
	{
		if(madePerCraft.ContainsKey(itemId))
		{
			return madePerCraft[itemId];
		}
		else
		{
			return -1;
		}
		
	}
	
	
	private bool IsMaterial(int IdOfItem)
	{
		return recipeDict.ContainsKey(IdOfItem);
		
	}
	
	public List<int> CheckCrafting(List<int> playerInventory)
	{
		List<int> craftableItems = new List<int>();
		foreach(KeyValuePair<int, List<int>> item in craftingDict)
		{
			if(CheckCrafting(item.Key, playerInventory))
			{
				//This item can be crafted!
				craftableItems.Add(item.Key);			

			}
		}
		return craftableItems;
	}
	
	
	public bool CheckCrafting(int itemId, List<int> playerInventory)
	{
		if(!craftingDict.ContainsKey(itemId))
		{
			return false;
		}
		List<int> recipe = craftingDict[itemId];
		int counter = recipe.Count/2;
		for(int i = 1; i <= recipe.Count; i += 2)
		{
			for(int j = 1; j <= playerInventory.Count; j += 2)
			{
				if(recipe[i] == playerInventory[j])
				{
					if(playerInventory[j-1] >= recipe[i-1])
					{
						counter--;
					}
					else
					{
						return false;
					}
				}
			}
		}
		
		if(counter == 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

}






















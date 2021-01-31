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

	private void InitiateRecipes()
	{
		//Make all of the crafting recipes here
		AddRecipe(7, new List<int> {1,6,  5,5 });
		AddRecipe(8, new List<int> {6,1, 6,2 });
		AddRecipe(9, new List<int> {6,3, 1,8 });
		AddRecipe(10, new List<int> {6,4,  1,9 });
		AddRecipe(11, new List<int> {5,5, 1,10 });
		AddRecipe(12, new List<int> {3,2,  9,1 });
		AddRecipe(13, new List<int> {3,3,  9,1 });
		AddRecipe(14, new List<int> {3,4, 9,1, 2,26 });
		AddRecipe(15, new List<int> {5,5, 9,1 });
		AddRecipe(16, new List<int> {10,1,  2,2,  3,27 });
		AddRecipe(17, new List<int> {6,4,  6,27,  3,26 });
		AddRecipe(18, new List<int> {1,2,  2,1}, 5);
		AddRecipe(19, new List<int> {1,3, 2,1 }, 4);
		AddRecipe(20, new List<int> {1,4, 2,1 }, 3);
		AddRecipe(21, new List<int> {20, 1 });
		AddRecipe(22, new List<int> {20,2 });
		AddRecipe(23, new List<int> {15,3 });
		AddRecipe(24, new List<int> {12,4 });
		AddRecipe(25, new List<int> {5,5 });
		AddRecipe(41, new List<int> { 1, 31, 1, 1 });
		AddRecipe(42, new List<int> { 1, 32, 1, 1 });
		AddRecipe(43, new List<int> { 1, 33, 1, 1 });
		AddRecipe(44, new List<int> { 1, 34, 1, 1 });
		AddRecipe(45, new List<int> { 1, 35, 1, 1 });
		AddRecipe(46, new List<int> { 1, 36, 1, 1 });

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


	public int[] CheckCraftingArray()
	{

		PlayerInventory inv = (PlayerInventory)GetNode("/root/PlayerInventory");

		List<int> convertedInventory = new List<int>();
		foreach(KeyValuePair<int, int> item in inv.Inventory)
		{
			convertedInventory.Add(item.Value);
			convertedInventory.Add(item.Key);
		}

		List<int> craftableItems = CheckCrafting(convertedInventory);

		int[] craftableArray = new int[craftableItems.Count];
		for(int i = 0; i < craftableItems.Count; i++)
		{
			craftableArray[i] = craftableItems[i];
		}

		//GD.Print(" C# calculated " + craftableArray.Length + " craftable items");
		return craftableArray;
		
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






















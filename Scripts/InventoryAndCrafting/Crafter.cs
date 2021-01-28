using Godot;
using System;
using System.Collections.Generic;

public class Crafter : Node
{

	//Never address these on their own; only use helper functions to input/output info from them!
	//These have to be dictionaries unless we want to add a null crafting recipe for everything that can't be directly crafted, which would be kinda dumb
	Dictionary<int, List<int>> craftingDict = new Dictionary<int, List<int>>();
	Dictionary<int, List<int>> recipeDict = new Dictionary<int, List<int>>();
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }




	//The formatted array must be as follows:
		//[amountOfItem, itemID, amountOfItemN, ItemNId]
		//This can go on however long you like, but it must be amount,id even if it is just 1 item/amount
	private void AddRecipe(int IdOfItem, List<int> formattedArray)
	{
		if(formattedArray.Count % 2 != 0)
		{
			return; //bail out if the array is odd, or else it might crash
		}
		
		craftingDict.Add(IdOfItem, formattedArray);
		
		//Adds the crafted item as a craftable for all the ingredients, for faster searching later
		for(int i = 1; i < formattedArray.Count; i+=2)
		{
			recipeDict[formattedArray[i-1]].Add(IdOfItem);
			/*
			if(recipeDict[formattedArray[i-1]] == null || recipeDict[formattedArray[i-1]].Count == 0)
			{
				//If it doesn't yet exist, just add it like you normally would
				recipeDict[formattedArray[i-1]].Add(IdOfItem);
			}
			else
			{
				//otherwise, append the list
				recipeDict[formattedArray[i-1]].Add(IdOfItem);
			}
			*/
		}
	}
	
	
	private bool UsedInRecipe(int IdOfItem)
	{
		if(recipeDict[IdOfItem] != null && recipeDict[IdOfItem].Count != 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	//Player inventory is also a List<int> where the values are amount:ID
	//This function returns a list of all craftable item IDs
	public List<int> CheckCrafting(List<int> playerInventory)
	{
		//Given the items that the player has, those are the only ones that need to be searched for for valid recipes.
		List<int> possibleRecipeIDs = new List<int>();
		
		for(int i = 1; i < playerInventory.Count; i+=2)
		{
			if (UsedInRecipe(playerInventory[i]))
			{
				//If the item is part of a crafting recipe, then also check if the player has enough of that and the rest
				bool hasAllItems = true;
				
				//get that items recipe
				List<int> tempStorage = craftingDict[playerInventory[i]];
				
				//search the player inventory for first the item itself
				for(int j = 1; i < tempStorage.Count; j+=2)
				{
					if(!hasAllItems) {break;}//Break out early if the player doesn't have this part of the recipe
					
					for(int invNum = 1; invNum < playerInventory.Count; invNum += 2)
					{
						if(!hasAllItems) {break;}
						
						if(playerInventory[invNum] == tempStorage[i])
						{
							//if the player has a needed item, make sure the player has enough
							if(playerInventory[invNum-1] >= tempStorage[j-1])
							{
								possibleRecipeIDs.Add(playerInventory[invNum]);
							}
							else
							{
								hasAllItems = false;
							}
						}
					}
				}
				


			}
		}
		
		return possibleRecipeIDs; //This will return any valid crafting recipes
		
	}

}






















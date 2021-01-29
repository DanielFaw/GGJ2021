using Godot;
using System;
using System.Collections.Generic;

public class Crafter : Node
{

	//Never address these on their own; only use helper functions to input/output info from them!
	//These have to be dictionaries unless we want to add a null crafting recipe for everything that can't be directly crafted, which would be kinda dumb
	Dictionary<int, List<int>> craftingDict;
	Dictionary<int, List<int>> recipeDict;
	

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		craftingDict = new Dictionary<int, List<int>>();
		recipeDict = new Dictionary<int, List<int>>();
		/*
		AddRecipe(1, new List<int>{2,2,5,3});
		AddRecipe(2, new List<int>{2,3,2,4});
		AddRecipe(3, new List<int>{2,2});
		AddRecipe(4, new List<int>{7,6});
		AddRecipe(5, new List<int>{10,7});
		AddRecipe(6, new List<int>{10, 69});
		AddRecipe(8, new List<int>{1, 2, 3, 4, 5, 6});
		AddRecipe(9, new List<int>{5, 8});
		AddRecipe(69, new List<int>{420,420});
		
		//GD.Print("Player's fake inventory contains 2,2,3,3,4,4,9,7,10,6,10,69");
		List<int> sneakyInventory = new List<int>{2,2,3,3,4,4,9,7,100,6,10,69,1,20, 5, 8, 420, 420};
		//Player can craft: ID2, ID3, ID4, ID6, ID8
		
		CheckCrafting(sneakyInventory);
		*/
		
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
	
	
	private bool IsMaterial(int IdOfItem)
	{
		return recipeDict.ContainsKey(IdOfItem);
		
	}
	
	public void CheckCrafting(List<int> playerInventory)
	{
		foreach(KeyValuePair<int, List<int>> item in craftingDict)
		{
			if(CheckCrafting(item.Key, playerInventory))
			{
				//This item can be crafted!
			}
		}
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






















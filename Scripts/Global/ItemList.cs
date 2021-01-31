using Godot;
using System;
using System.Collections.Generic;

public sealed class ItemList : Node
{

	Dictionary<int, ItemInfo> itemInfoDict = new Dictionary<int, ItemInfo>();

	public override void _Ready()
	{
		
		//GD.Print("ItemList is ready!");
		Directory itemLocation = new Directory();
		itemLocation.Open("res://Prefabs/Items");
		for(int i = 1; i < 51; i++)
		{
			string itemToSearch = "Item" + i + ".tscn";
			if (itemLocation.FileExists(itemToSearch))
			{
				PackedScene myScene = (PackedScene)GD.Load("res://Prefabs/Items/" + itemToSearch);
				ItemInfo infoLoaded = (ItemInfo)(myScene.Instance().GetNode("IDScript"));

				//GD.Print(itemToSearch + " exists in the files");
				AddItem(infoLoaded);
			}
		}

	}


	public void AddItem(ItemInfo item)
	{
		if(!itemInfoDict.ContainsKey(item.itemId))
		{
			itemInfoDict.Add(item.itemId, item);
			//GD.Print(item.itemName);
			//GD.Print(item.description);
		}

	}


	public ItemInfo RetrieveItemInfo(int itemId)
	{
		if(itemInfoDict.ContainsKey(itemId))
		{
			if(itemInfoDict[itemId] != null)
			{
				return itemInfoDict[itemId];
			}
		}

		return null;
	}
	
	public string RetrieveItemName(int itemId)
	{
		if(itemInfoDict.ContainsKey(itemId))
		{
			return itemInfoDict[itemId].itemName;
		}
		else
		{
			GD.Print("Item doesn't exist");
			return null;
		}
	   

	}
	
	public string RetrieveItemDescription(int itemId)
	{
		return itemInfoDict[itemId].description;
	}

	public Texture RetrieveItemTexture(int itemId)
	{
		return itemInfoDict[itemId].itemIcon;
	}

	public Node RetrieveItemBody(int itemId)
	{
		return itemInfoDict[itemId].GetParent().GetNode("body");
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}

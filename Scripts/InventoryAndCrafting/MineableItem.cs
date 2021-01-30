using Godot;
using System;

public class MineableItem : Node
{
    [Export] int amountOfItemsToSpawn = 5;
    [Export] int hardness = 1;
    [Export] int itemIdDropped = 0;

    public override void _Ready()
    {
    }

    public void HitItem()
    {
        amountOfItemsToSpawn--;
        if(amountOfItemsToSpawn == 0)
        {
            //drop
        }
    }

    

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}

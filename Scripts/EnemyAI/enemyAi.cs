using Godot;
using System;

//While idle, enemy will only check the distance to the player, and maybe move around a tiny bit
//While not idle, the enemy will go to a certain distance and start attacking while in a certain range,
//but won't run away from you


public class enemyAi : Node
{
    bool isIdle = true;
    [Export] public float attackRange = 10f;
    [Export] public int attackDamage = 2;
    [Export] public float timeBetweenAttacks = 2f;
    private float attackTimer = 0f;
    [Export] public int health = 30;
    [Export] public int itemIdDroppedOnDeath = 1;

    //Hardcoding for 8 rays to be cast out to determine distances and stuff
    private float rayLength = 3f;
    private float timer = 0f;
    private float distanceToPlayer;
    private Vector3 currentVector;

    public enemyspawning homeSpawner;

    public override void _Ready()
    {
        
    }

    public void SetHomeSpawner(enemyspawning home)
    {
        homeSpawner = home;
    }

    public override void _Process(float delta)
    {
        if(!isIdle)
        {
            timer += delta;
            if (timer > 1f)
            {
                timer = 0;
                RayCastCheck();
            }

            if(distanceToPlayer > 3f)
            {
                Movement();
            }
            AttackPlayer(delta);

        }
        else
        {
            //Idle wandering goes here if we have time
            if(distanceToPlayer < 25f)
            {
                isIdle = false;
            }
        }

    }

    private void Movement()
    {
        //Just do rigidbody movement stuff here, using the current vector as the movement vector, maybe with some smoothing inbetween
    }

    private void RayCastCheck()
    {
        //Cast 5 rays pointed toward the player and take the best path
        //The best path is whichever line is longest, but is stopped completely when hitting another object or enemy
        //The middle line is initially the longest, with the 2 next to it a little shorter, and the ones next to that shorter still




        RayCast[] castList = new RayCast[5];
        float[] angles = new float[5];
        angles[0] = -45f;
        angles[1] = -22.5f;
        angles[2] = 0f;
        angles[3] = 22.5f;
        angles[4] = 45f;
        //45 is about half the distance
        //22.5 is about 3/4 the distance
        //0 is untouched distance

        //The casts will go from left to right
        for (int i = 0; i < 5; i++)
        {
            castList[i] = new RayCast();
            castList[i].CastTo = new Vector3(); //should just multiply it by the direction to player * angle and then multiply the distance
        }

        //find out which raycast is the longest
        //if (raycast.GetCollider != null)
        //    distance = raycast.GetCollisionPoint - this.position
        //else
        //    distance = whatever value was in the array above

        //a small largest value thing
        int bestIndex = 0;
        float bestPath = -1f;
        for(int i = 0; i < 5; i++)
        {
            //if(distance[i] > bestPath
                //bestIndex = i;
                //bestPath = distance[i]
        }

        //currentVector = distance.normalized

        
        
    }

    private void AttackPlayer(float deltaTime)
    {
        if(distanceToPlayer < attackRange)
        {
            attackTimer += deltaTime;
            if(attackTimer > timeBetweenAttacks)
            {
                attackTimer = 0f;
                //deal attackDamage damage to the player
            }
        }
    }

    private void DistanceToPlayer()
    {
        //honestly idk how to get this, its currently 6:36am
    }

    public void TakeDamage(int amount)
    {
        health -= amount;
        if(health < 1)
        {
            QueueFree();
            homeSpawner.DeadEnemy();
            DropLoot();
        }
    }

    private void DropLoot()
    {
        //75% chance of dropping the item
        if(GD.RandRange(0, 1) > .25)
        {
            PlayerInventory pInv = GetNode("/root/PlayerInventory") as PlayerInventory;

            pInv.AddItem(1, itemIdDroppedOnDeath);
        }

    }


}

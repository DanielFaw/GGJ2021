using Godot;
using System;

public class enemyspawning : Node
{
    //this is the basis of 'camps' that will be scattered around the land
    //they spawn enemies at a certain rate, and up to a certain amount
    //'harder' camps can be around higher value resources
    [Export] public int maxEnemiesSpawned = 5;
    private int currentSpawnedEnemies = 0;
    [Export] public float timeBetweenSpawns = 20f;
    private float spawnTimer = 0f;
    [Export] public float maxSpawnRange = 10f;
    [Export] public PackedScene enemyToSpawn;


    public override void _Process(float delta)
    {
        if(currentSpawnedEnemies < maxEnemiesSpawned)
        {
            spawnTimer += delta;
            if(spawnTimer > timeBetweenSpawns)
            {
                currentSpawnedEnemies++;
                SpawnEnemy();
                spawnTimer = 0;
            }
        }
    }

    //Spawned enemies will call this when they die
    public void DeadEnemy()
    {
        currentSpawnedEnemies--;
    }

    private void SpawnEnemy()
    {
        //AddChild(enemyToSpawn);
        //enemyAi myAI = GetNode(enemyToSpawn) as enemyAi;
        //myAI.SetHomeSpawner(this);
    }


}

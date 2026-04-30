using System.Collections.Generic;
using UnityEngine;

public class SnakeBot : AIBehavior
{
    // ===== CONFIG =====
    public float dangerDistance = 3.0f;
    public float foodDetectionRadius = 10.0f;

    // ===== ESTADOS =====
    private enum State
    {
        SEEK_FOOD,
        AVOID,
        WANDER
    }

    private State currentState;

    // ===== PERCEPÇÃO =====
    private Transform closestFood;
    private Transform closestEnemy;

    // ===== UNITY LOOP =====
    void Update()
    {
        Perceive();
        Decide();
        Act();
    }

    // =========================
    // 👀 PERCEPTION
    // =========================
    void Perceive()
    {
        closestFood = GetClosestFood();
        closestEnemy = GetClosestEnemy();
    }

    Transform GetClosestFood()
    {
        GameObject[] foods = GameObject.FindGameObjectsWithTag("Food");

        float minDist = Mathf.Infinity;
        Transform closest = null;

        foreach (GameObject food in foods)
        {
            float dist = Vector3.Distance(transform.position, food.transform.position);

            if (dist < minDist && dist <= foodDetectionRadius)
            {
                minDist = dist;
                closest = food.transform;
            }
        }

        return closest;
    }

    Transform GetClosestEnemy()
    {
        GameObject[] snakes = GameObject.FindGameObjectsWithTag("Snake");

        float minDist = Mathf.Infinity;
        Transform closest = null;

        foreach (GameObject snake in snakes)
        {
            if (snake.transform == this.transform)
                continue;

            float dist = Vector3.Distance(transform.position, snake.transform.position);

            if (dist < minDist)
            {
                minDist = dist;
                closest = snake.transform;
            }
        }

        return closest;
    }

    // =========================
    // 🧠 DECISION
    // =========================
    void Decide()
    {
        if (closestEnemy != null)
        {
            float distEnemy = Vector3.Distance(transform.position, closestEnemy.position);

            if (distEnemy < dangerDistance)
            {
                currentState = State.AVOID;
                return;
            }
        }

        if (closestFood != null)
        {
            currentState = State.SEEK_FOOD;
        }
        else
        {
            currentState = State.WANDER;
        }
    }

    // =========================
    // 🎮 ACTION
    // =========================
    void Act()
    {
        switch (currentState)
        {
            case State.SEEK_FOOD:
                SeekFood();
                break;

            case State.AVOID:
                AvoidEnemy();
                break;

            case State.WANDER:
                Wander();
                break;
        }
    }

    // =========================
    // MOVEMENTS
    // =========================

    void SeekFood()
    {
        if (closestFood == null)
            return;

        Vector3 direction = (closestFood.position - transform.position).normalized;

        SetDirection(direction);

        // Dash se estiver perto da comida
        float dist = Vector3.Distance(transform.position, closestFood.position);
        SetBoost(dist < 2.0f);
    }

    void AvoidEnemy()
    {
        if (closestEnemy == null)
            return;

        Vector3 direction = (transform.position - closestEnemy.position).normalized;

        SetDirection(direction);

        // Sempre dash ao fugir
        SetBoost(true);
    }

    void Wander()
    {
        Vector3 randomDir = new Vector3(
            Random.Range(-1f, 1f),
            0,
            Random.Range(-1f, 1f)
        ).normalized;

        SetDirection(randomDir);

        SetBoost(false);
    }
}
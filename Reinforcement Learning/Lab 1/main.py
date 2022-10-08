# adrian.stoicescu@s.unibuc.ro
import sys
import numpy as np
import gym
import time

env = gym.make("FrozenLake-v1", map_name="4x4", is_slippery=False)

def runEpisode(env, policy, maxSteps = 100):
    total_reward = 0
    observation = env.reset()[0]
    for t in range(maxSteps):
        env.render()
        time.sleep(0.25)
        action = policy[observation]
        newObservation, reward, done, _, _ = env.step(action)
        print(f"From {observation} reached {newObservation} by step {action}")
        observation = newObservation
        total_reward += reward
        if done:
            break

    if not done:
        print(f"The agent didn't reach its goal in {maxSteps} steps")
    else:
        print(f"Total reward: {total_reward}")
    env.render()

env.nA = 4
env.nS = 16
random_policy = np.random.choice(env.nA, size=env.nS)
print(random_policy)
runEpisode(env, random_policy, 10)
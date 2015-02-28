# Collect Em All

This idea is a game where the user attempts to collect interesting creatures. The creatures are scattered around the map, and are collected by the first user to walk over them.

## Gameplay
### Creature collection
The user leaves the app running as they walk around their city. When they walk over a location where a creature is located, a notification is triggered informing them that they have collected the creature. This creature is then no longer available for other users to collect. The user is able to view their collection of creatures in the app. Users do not know beforehand where creatures are located, they must explore their city to find them.

### Creature feeding/training
There is also a concept of food which is scattered around the map. The user designates one creature in their collection as the active creature. Any food items that are walked over "feed" the creature, making it stronger. If the user does not feed the creature enough, it will "run away". Food items are used up as they are collected, and will regenerate slowly, forcing the user to explore new locations to gather more food and creatures.

## Creatures
Each creature has a name and a piece of artwork associated. An example of a creature could be a Pokemon.

## Interface
There are several screens providing the gameplay experience.

### Gallery
This is a collection view showcasing the creatures that have been collected so far.

### Creature Detail
This is a screen showing details about the creature, such as where it was found, how much food it has eaten, etc.

### Notifications
A notification pops up when a user has collected a creature. It shows the creature and congratulates the user on their find. There is also a notification for WatchKit.

### Food map
This map helps the user know where to gather food for the creature. It shows a heatmap of where the user has been recently. By going to places that they haven't been, the user is able to gather more food for their creature.
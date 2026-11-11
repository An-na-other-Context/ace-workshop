# ai-learning

AI-made learning material for building ACE Workshop: notes, small code examples and goals for learning Godot and programming.

> **Made by AI.** Everything in this folder is written by Claude, an AI assistant made by Anthropic. Each file says what was checked and what wasn't.

## Kept apart from the game

- **Not part of the game.** Nothing here belongs to ACE Workshop or to its learning content. The game's learning content is made by people (see [CONTRIBUTING.md](../CONTRIBUTING.md)).
- **No `class_name`.** GDScript has no namespaces: a `class_name` registers a class for the whole project. Scripts in this folder have no `class_name` and load each other by path instead, for example `const Animal = preload("res://ai-learning/oop/animal.gd")`. So nothing from here appears in the game's list of classes.
- **Left out of exports.** Every export preset leaves out `ai-learning/*`. No preset exists yet; setting one up is a puzzle on the board.
- **No generative-AI art.** Images, models, sounds and other art here follow the same rule as the rest of the repository: made in code or by people, with credit.

## What goes here

- notes, for example on OOP (object-oriented programming)
- small code examples to open and change in the Godot editor
- goals for learning the editor

Each piece belongs to a puzzle on the [ACE Workshop board](https://github.com/orgs/An-na-other-Context/projects/1).

## Licence

Same as the rest of the repository: code under AGPL-3.0, everything else under CC BY-SA 4.0.

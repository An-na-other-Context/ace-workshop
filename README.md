# ACE Workshop

A learning environment in the shape of a game: a calm 3D workshop where you take real machines apart, layer by layer, and put them back together — to understand how computers and operating systems work, from the hardware up.

It is separate from [ACE OS](https://github.com/An-na-other-Context/ace-os) (An(na)other Context Engine OS), and a first step towards it.

> Status: just started. The game has no scenes of its own yet. An AI-made graybox (a gray desk with three machines — a self-built PC, an older car's in-dash unit, a smart plug — and the goal lab) sits in [ai-learning/graybox](ai-learning/graybox) as an example, kept apart from the game.

Game design documents (Excalidraw boards) live in [design/](design/README.md), outside the game.

## Open it

1. Install [Godot 4.7](https://godotengine.org) (the standard version, not .NET).
2. In Godot's Project Manager: **Import** → choose `project.godot` in this folder.
3. There is no main scene yet. To look at the AI-made graybox: open `ai-learning/graybox/workshop.tscn` and press **Run Current Scene** (F6).

Scripts are GDScript, so the game can later be exported to the web.

## Licence

Open source, and it stays that way: anyone who receives it, also by buying it, gets the source and the same right to share it freely.

| What | Licence |
|---|---|
| Code (scripts, scenes, config) | [AGPL-3.0](LICENSE.md) |
| Everything else (text, models, images, audio) | [CC BY-SA 4.0](LICENSE-CONTENT.txt) |
| Project rules | [CONTRIBUTING.md](CONTRIBUTING.md) — no AI-made content (AI may help with code and docs), no malicious use |
| Engine and credits | [CREDITS.md](CREDITS.md) — made with Godot (MIT) |

Copyright (c) 2026 annaothercrow (https://github.com/annaothercrow)

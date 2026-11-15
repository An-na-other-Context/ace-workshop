# design

ACE Workshop's game design documents, as [Excalidraw](https://excalidraw.com) boards: short notes, pictures and arrows that connect ideas.

The folder sits outside the game: the empty file `.gdignore` makes Godot skip it (no import, hidden in the editor).

## What's here

| File | What it is |
|---|---|
| `start-here.excalidraw` | The design board, a mind-map GDD: the centre, 12 topics taken from real game design documents, a Design goals topic with the branches specific to ACE Workshop, the colour legend, a "where I stopped" card. Dark board look since 15.11.2026. Why these topics: [research record](../ai-assisted/claude/research/README.md). |
| `library/ace-notes.excalidrawlib` | The library VS Code shows by default: the 8 basic note cards to drag in (idea, question, decision, research note, where I stopped, voice or video note, bookmark, research question), then each design-cycle tool's smallest start-to-finish sheet (2x, or its only one), phase by phase. |
| `library/cycle/*.excalidrawlib` | One library per phase of the [design cycle](../ai-assisted/claude/design-cycle/README.md) (`1-understand` … `7-reflect`), plus `misc` for the helper tools: the 8 basics at the top, then every preset (containers in 2, 4, 6, start-to-finish sheets) and every card of its boards. Names read "phase · tool · item", for example "1 Understand · Problem statement · Write a few 2x". Load one in the library panel when you need it. |
| `library/catalogue.excalidraw` | The catalogue: one row per phase, one column per tool. Each column says where the tool's presets live (its presets board, its library) and shows every card of the tool at full size, ready to copy. |
| `media/` | Voice and video notes (Excalidraw can't hold them). See [media/README.md](media/README.md). |

## Open and edit

Both ways show the same visual board; neither shows code.

**In the browser (excalidraw.com)**
1. Open [excalidraw.com](https://excalidraw.com). To use it offline, install it as an app from your browser's menu.
2. Open `start-here.excalidraw` from this folder.
3. Save it back into this folder. *Not confirmed yet:* whether it saves into the same file. If it downloads a new file instead, replace the old one with it.
4. Note cards: load `library/ace-notes.excalidrawlib` in the library panel.

**In VS Code or VSCodium**
1. Install the extension "Excalidraw" by pomdtr.
2. Open `start-here.excalidraw`: the board opens instead of the text.
3. The note cards are connected through `.vscode/settings.json` (setting `excalidraw.workspaceLibraryPath`). *Not confirmed yet:* whether the extension is on VSCodium's store (Open VSX).
4. One phase at a time: the library panel has no folders and reads one file, so to see a phase's presets and cards, point the setting at that phase, for example `"excalidraw.workspaceLibraryPath": "design/library/cycle/1-understand.excalidrawlib"` (or `2-observe` … `7-reflect`, `misc`). The basics stay on top. Back to `design/library/ace-notes.excalidrawlib` for the basics and the start-to-finish sheets. *Not confirmed yet:* whether the panel keeps the file's order, whether items you add in the panel get written into that file, and whether a board needs closing and reopening after the switch.

Fonts: the boards use Nunito, a rounded plain font (Anna's pick, 14.11.2026). You can change it per note in the app.

## Colour legend

The boards are dark by default: background `#1f2326`, text `#f1ece2`, no outlines. Rename or recolour freely.

| Colour | Meaning | Shade on the dark boards |
|---|---|---|
| Green | Idea | `#2e6a47` |
| Blue | Question | `#285a86` |
| Violet | Decision | `#523f94` |
| Teal | Research note | `#2a6b5e` |
| Yellow | Where I stopped | `#7d6418` |
| Grey | Voice or video note (file in `media/`) | `#3d454a` |

On the design-cycle boards, two more: dark grey `#30373c` = a card to fill in, bright teal `#4fae94` = chosen or ticked.

**Ladders** (light to deep, so you can see where you are without reading):

- Steps of a tool's loop: mauve grey, from `#d6cad6` (step 0) to `#352d38`, as a thin stripe on top of each container and a small square on each "from" and "next" chip (Anna's pick, 15.11.2026).
- Phases of the design cycle: sand, from `#d8c8a8` (1 Understand) to `#5f4f30` (7 Reflect), in each board's legend; the board's own phase is marked.

No red or orange, by design.

## Who made what

- The starter layout, the note cards and these READMEs were made by Claude (AI) on 14.11.2026: structure only, no design content.
- The dark restyle of the start map and the note cards, and the phase libraries, were made by Claude (AI) on 15.11.2026, in the board look Anna (@annaothercrow) set; the start map's shapes, positions and arrows are unchanged.
- Everything on the boards is made by people (see [CONTRIBUTING.md](../CONTRIBUTING.md)), except research notes that say "AI draft": Claude drafts those (dashed teal cards with a link to the research record), and the arrows from them are drawn by people.
- Licence of the board content: CC BY-SA 4.0 ([LICENSE-CONTENT.txt](../LICENSE-CONTENT.txt)).

## Words

- **Excalidraw:** a free, open-source drawing board that runs in the browser.
- **Topic:** a main node near the centre, one per GDD section.
- **Branch:** a line growing out of a topic, or a connection between nodes.
- **Design node:** any single thing on the board: a note, picture, voice note, question.
- **Concept:** a node that holds an idea or a principle.
- **Area:** a region where related branches gather, possibly across topics.
- **GDD:** game design document.
- **Library:** a set of ready-made shapes you can drag onto any board.
- **Preset:** a ready-made container or sheet from a design-cycle tool, in a set size (2, 4 or 6 cards), to copy and fill in.
- **Ladder:** a row of shades from light to deep; each shade stands for one step or one phase.
- **.gdignore:** an empty file that tells Godot to leave a folder alone.

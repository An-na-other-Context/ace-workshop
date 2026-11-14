# design

ACE Workshop's game design documents, as [Excalidraw](https://excalidraw.com) boards: short notes, pictures and arrows that connect ideas.

The folder sits outside the game: the empty file `.gdignore` makes Godot skip it (no import, hidden in the editor).

## What's here

| File | What it is |
|---|---|
| `start-here.excalidraw` | The design board, a mind-map GDD: the centre, 12 topics taken from real game design documents, a Design goals topic with the branches specific to ACE Workshop, the colour legend, a "where I stopped" card. Why these topics: [research record](../ai-assisted/claude/research/README.md). |
| `library/ace-notes.excalidrawlib` | Note cards to drag in: idea, question, decision, research note, where I stopped, voice or video note. |
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

Fonts: the starter board uses Excalidraw's plain font, not the hand-drawn one. You can change it per note in the app.

## Colour legend

My suggestion, rename or recolour freely.

| Colour | Meaning |
|---|---|
| Green | Idea |
| Blue | Question |
| Violet | Decision |
| Teal | Research note |
| Yellow | Where I stopped |
| Grey | Voice or video note (file in `media/`) |

No red or orange, by design.

## Who made what

- The starter layout, the note cards and these READMEs were made by Claude (AI) on 14.11.2026: structure only, no design content.
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
- **.gdignore:** an empty file that tells Godot to leave a folder alone.

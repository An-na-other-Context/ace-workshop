# Contributing to ACE Workshop

Thank you for wanting to help. These rules apply to everything added to this repository.

## 1 · No AI-made content

- Learning content — text, images, audio, drawings and any other media — must be made by humans.
- Exception: **code** and **project docs** (README, CONTRIBUTING, setup notes) may be written with AI help.
- Mark AI-assisted commits, for example with a `Co-Authored-By:` line naming the AI tool.
- Explainer text inside the game counts as docs and may be AI-drafted, but it must show:
  - that it is AI-drafted and how it was researched,
  - a source on every claim (official, encyclopedia, tutorial, study, opinion, AI simplification, sources disagree),
  - and cautions on what is not checked.
- 3D models, textures and sprites: built in code or made by people, with a fitting licence and credit in [CREDITS.md](CREDITS.md). Never generative-AI art.
- Everything AI-made lives in [ai-assisted/](ai-assisted/README.md), one folder per AI tool (so far `ai-assisted/claude/`). It is marked as AI-made, is not part of the game or its learning content, and is left out of every export. [learning/](ai-assisted/claude/learning/README.md) holds AI-made learning material (notes and code examples for learning Godot and programming); scripts there use no `class_name`. [research/](ai-assisted/claude/research/README.md) keeps the research behind finished board cards, with a decision note for each. No generative-AI art there either.
- The folder [design/](design/README.md) holds the game design documents (Excalidraw boards). Their content is made by people; AI may only set up empty layouts, note-card templates and docs, marked as AI-made.

## 2 · No malicious use

- Do not contribute anything meant to harm people.
- Do not use or extend this project to harm people.

## 3 · The base stays free and open

- Commercial use is welcome, within the licenses.
- The base itself stays freely accessible to anyone who needs it or wants to contribute: code under AGPL-3.0, everything else under CC BY-SA 4.0.

## Good to know

- These rules bind contributions **to this repository**.
- What others may do with copies is decided by the licenses: [LICENSE.md](LICENSE.md) for code, [LICENSE-CONTENT.txt](LICENSE-CONTENT.txt) for everything else.

#  Caesars Palace Dice Game

A terminal-based casino dice game written entirely in **Bash/Shell**.

This project was developed as part of a semester assignment and recreates a casino-style experience directly in your terminal, featuring colorful output, animated dice rolls, and both single-player and multiplayer modes. The interface and game messages are in French.

---

## Features

### Game Modes
- **Single Player** – Try to complete all winning combinations as quickly as possible.
- **Local Multiplayer** – Challenge your friends on the same machine.

###  Terminal Experience
- Custom dice-rolling animations using `tput`
- Colored terminal output for an immersive casino atmosphere
- Simple and intuitive text-based interface

###  Winning Conditions

To win the game, a player must achieve all **three unique combinations** at least once:

| Combination | Description |
|------------|-------------|
| **Tris** | Three of a kind (all three dice show the same value) |
| **Paire** | A pair (at least two dice show the same value) |
| **Échelle** | The three dice show consecutive values |
---

## Requirements

- Linux or macOS
- Bash shell
- A terminal supporting ANSI colors and `tput`

No additional dependencies are required.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/amecib/Dice_game_in_bash.git
cd Dice_game_in_bash
```

Make the script executable:

```bash
chmod +x Dice_Game.sh
```

Run the game:

```bash
./Dice_Game.sh
```

---

## Example

```text
🎲 Rolling the dice...

┌───┐ ┌───┐ ┌───┐
│ 6 │ │ 6 │ │ 6 │
└───┘ └───┘ └───┘

✔ Tris completed!
```

---

## Technologies Used

- Bash / Shell scripting
- ANSI escape sequences
- `tput` for terminal control and animations

---

## Author
This project was developed by Amecib as part of a university semester project at Paris Dauphine–PSL University. If you wish to credit this work, feel free to message me for my full real
name.

---
**Please note:** While this documentation is in English, the game's interface, menus, and terminal messages are entirely in French.

---

## Disclaimer
**Please note:** This is an independent student project developed for academic purposes. It is not officially affiliated with, endorsed by, or maintained by Paris Dauphine–PSL University. The university bears no responsibility for the code, data handling, or any potential issues arising from the use of this software.

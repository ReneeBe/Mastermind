# Mastermind
A mastermind-style game for iOS built in Xcode 13.3 in Swift, using. This game was developed for the Summer 2022 LinkedIn REACH Mobile Apprenticeship Opportunity. 

## About Mastermind Game
Mastermind was developed in Xcode 13.3 using Swift, SwiftUI, and the Random generator API(https://www.random.org/clients/http/api/) over 7 days and supports all iPhone models currently for sale (excluding refurbished models) at the Apple Store. Mastermind supports play in light mode and dark mode (essential if you are playing a game because you can't sleep!) and is meant to be run in portrait mode. Mastermind is a single-player game where the player has up to 10 opportunities to guess a secret passcode consisting of 8 numbers between and including 0-7. Each submitted guess receives feedback next to it. The feedback consists of four dots that correspond (not in corresponding order) to individual values within the guess. A green dot indicates a guess was correct in value and location in the passcode, a yellow dot indicates a guess was correct in value but incorrect on location in the passcode, and a red dot indicates a guess was entirely incorrect. The player can start a new game at any time in game play by pressing the "plus" button on the top right corner of the screen.

Mastermind was built using the MVVM architectural pattern, with a Model to store game data such as the guess history and secret password. The model also generates the password using the Random generator API. Mastermind has a ViewModel that helps manage and evaluate interactions between a series of views and the model. The ViewModel also helps to generate feedback on the player's guesses and the game's status (won, lost, or in progress).
 
## Install and Run Mastermind
These instructions assume you will run Mastermind on a MacOS computer, and provide one method for cloning the repository and running the game, but there are many other methods. If you are familiar with cloning from github and running an app on Simulator from Xcode, these instructions may be unnecessary.

### Clone The Repository
First, please ensure you have the latest Xcode(https://apps.apple.com/us/app/xcode/id497799835?mt=12)and Simulator. 

Once you have Xcode installed, click the green "Code" button on https://github.com/ReneeBe/Mastermind and select open with Xcode. You will be asked "Do you want to allow this page to open "Xcode"?" you can select "allow" and then you will be prompted to select a folder to save the project, and then hit "Clone." Xcode will open Mastermind code.

### Run the game on simulator
Command + R will run Mastermind in Simulator. You can select the iPhone model to simulate Mastermind by clicking on the bar on the top of the Xcode window and selecting the iPhone model you prefer.

### Game Play
You can input your guesses by selecting a box on the highest row of unfilled boxes, and then inputting using your mouse and the number pad on screen or using your keyboard. After you have selected your guess for a full row, a checkmark will appear to submit your guess, and will return feedback on your guess.

## Future Plans for Upgrades to Mastermind Game
I wanted to add the option to use colors instead of numbers but was unable to create a suitable custom color picker with my remaining time. I put a "gear" on the top left side of the screen to use as a button to open a menu to configure settings such as value types, but it is currently invisible while there are no configurable settings. After that upgrade, I would like to add a cofigurable difficulty level, which changes the number of potential values for each point in the secret combination.

## Author
Renee Berger

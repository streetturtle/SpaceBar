# SpaceBar

MacOS menu bar application for JetBrains Space:

<p align="center">
  <img width="630" alt="Screen Shot 2022-11-05 at 3 21 03 PM" src="https://user-images.githubusercontent.com/9363150/200137309-2dd633ad-ad3a-4f17-9a18-8ec4dddac748.png">
</p>

This app is created for the [Space Apps Contest 2022](https://plugins.jetbrains.com/contest/space/2022)

## Features

 - supports multiple projects
 - issues
   - open issue on click
   - change issue status
   - filter issues by created/assigned and by status
 - code reviews
   - open code review on click
   - shows title, number, source/target branch
 - todo items:
    - toggle state: done / undone
    - delete todo item
    
## Instalation

Download [the latest release](https://github.com/streetturtle/SpaceBar/releases/download/v1.0/SpaceBar.1.0.dmg) and install it. Then generate a token in Space with following permissions:
 - Manage issue settings,
 - Read Git repositories,
 - Update issues,
 - View code reviews,
 - View issues,
 - View project details

Then paste it in the settings tab with your space org:

<p align="center">
  <img width="630" alt="Screen Shot 2022-11-05 at 3 26 58 PM" src="https://user-images.githubusercontent.com/9363150/200137545-efcbb21f-d9d1-47d1-bc66-77897c37d420.png">
</p>

Note that the token is securely stored in macOS keychain, so when starting the application you will you will neet to type your password in a prompt. This is done to allow the app to store and read token from the keychain.


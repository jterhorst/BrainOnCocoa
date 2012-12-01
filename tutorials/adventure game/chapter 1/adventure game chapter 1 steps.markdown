Covering Mac, not iOS. Simple, easy adventure game.

Do you have the latest Xcode? You can get the latest Xcode from App Store. Free.
https://itunes.apple.com/us/app/xcode/id497799835?mt=12

Start new project in Xcode.

"StupidAdventure"

Show nib layout:
- 4 buttons
- Start button
- custom view

Frame up code in AppDelegate
- array for rooms
(We use NSMutableArray here, because mutable means modifiable after creation. Many Cocoa classes have equivalents.)
- empty IBActions for north, south, east, west, and start


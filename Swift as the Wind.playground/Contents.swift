/*:
 ## 💨 Swift as the Wind 💨⛵️
 
 ### The Goal
 Cross the **finish line** with your sailing boat. Try to collect as many **coins** as you can.
 
 ### How To Play
 Move your fingers **around** the ship’s wheels. The left wheel **rotates the boat**, the right one **rotates the sail**.
 
 ### Note
 This playground is best experienced in **fullscreen mode**.
 
 ### Art Credits
 
 The **background musics** were composed by me with GarageBand. The **graphics elements**, including **maps**, **boat**, **ship’s wheels**, **coins**, **buttons** and **animations** were also designed by me.
 
 The **fish** and **lightning** inside the coins were downloaded from freepik.com. All the **audio effects** are public domain.
 */

import PlaygroundSupport
import SpriteKit

// Load the MenuScene from 'menuScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = MenuScene(fileNamed: "menuScene") {
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

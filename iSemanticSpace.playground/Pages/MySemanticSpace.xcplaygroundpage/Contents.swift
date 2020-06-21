import SpriteKit
import PlaygroundSupport
import UIKit
import Foundation

/*:
# WWDC 2020 Playground: iSemanticSpace

 ### Welcome to Ali Eren's Playground Book!
 
 I am very excited to create "Your Own Semantic Space" with you today!
 
 I tried to gamify a description of the Semantic Spaces in a fun way! I had fun while coding this playground and I hope that you will also have fun while playing!
 
 Before starts, I would like to introduce what NLP is and what Semantic Spaces are. Briefly, Natural Language Processing is ability of a 
 computer program to understand human language as it is spoken. At this point, semantic spaces are representations of natural language that are
 capable of capturing the meaning of the words in huge dimensional matrix spaces. Such a cool isn't it?
 Yes NLP is really cool!
 
 **But first could you tell me your name?**
 */

UserInput.shared.name = "Tim Cook" //Write your name here :)

/*:
 OK! After you enter your word that you want to create its Semantic Space, you can start the game!
 **Have FUN!**
 
Be sure your word is a *regular* **English** word, in this way game will more simple too :)
 */

UserInput.shared.word = "computer" //Write your word here :)

let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 512, height: 512)))
let scene = WelcomeScene(size: skView.frame.size)
skView.presentScene(scene)
PlaygroundPage.current.liveView = skView

/*:
 ## Credits:
 * This playground is created for **WWDC 2020 Apple Student Challange**.
 
 * Sounds that used in this playground retrieved from: *freesound.org*
 
 * Image that used in this playground retrieved from: *flickr.com*
 
 ### Ali Eren Ak Istanbul, Turkey
 */

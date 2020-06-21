import SpriteKit
import PlaygroundSupport
import UIKit
import AVFoundation

let width = 512 as CGFloat
let height = 512 as CGFloat

public class BrewingScene: SKScene {
    var positions = [[(310,400), (240,415),(330,413),(360,388),(290,385),(220,395)], 
                     [(420,310), (410,300),(315,315),(380,335),(440,323),(440,290)],
                     [(150,300), (110,285),(90,310),(190,315),(190,285),(160,330)],
                     [(330,240), (270,225),(420,240),(330,255),(390,230),(325,210)],
                     [(140,240), (45,240),(75,260),(130,230),(160,215),(150,255)]]
    var wrongPos = [(50,30),(280,20),(440,160),(120,140),(50,95),(440,70),(460,10), (230,90)]
    
    var baseWord: SKLabelNode!
    var secWord1: SKLabelNode!
    var currSeconds: [SKLabelNode] = []
    var wrongWord1: SKLabelNode!
    var semanticTitle: SKLabelNode!
    
    
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        background()
        addBaseWord()
        addSecondWords()
        addWrongWords()
        semantic()
    }
    
    func background() {
        var background: UIImage = #imageLiteral(resourceName: "night.png")
        let backgroundTexture = SKTexture(image: background)
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.size = CGSize(width: 512, height: 512)
        backgroundNode.position = CGPoint(x: 256, y: 256)
        backgroundNode.name = "background"
        backgroundNode.zPosition = 0
        addChild(backgroundNode)
    }
    
    func addBaseWord() {
        baseWord = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        baseWord.text = UserInput.shared.word
        baseWord.name = "round"
        baseWord.fontSize = 20
        baseWord.fontColor = .white
        baseWord.position = CGPoint(x: 320 , y: 350)
        addChild(baseWord)
    }
    
    func semantic() {
        semanticTitle = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        semanticTitle.text = UserInput.shared.name + "'s \nSemantic Space"
        semanticTitle.name = "round"
        semanticTitle.fontSize = 24
        semanticTitle.fontColor = UIColor(rgb: 0x22272a)
        semanticTitle.position = CGPoint(x: 300 , y: 475)
        addChild(semanticTitle)
    }
    
    func addSecondWords() {
        print(WordManager.giveSimilar)
        for sword in WordManager.giveSimilar {
            let index = WordManager.giveSimilar.firstIndex(of: sword)
            secWord1 = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
            secWord1.text = sword
            secWord1.name = "round"
            secWord1.fontSize = 14
            secWord1.fontColor = UIColor(rgb: 0xF4D24F)
            secWord1.position = CGPoint(x: self.positions[index!][0].0, y: self.positions[index!][0].1)
            addChild(secWord1)
            currSeconds.append(secWord1)
        }
        
        for w in currSeconds {
            let index = currSeconds.firstIndex(of: w)
            print(WordManager2.similarListTotal.count)
            print(WordManager2.similarListTotal)
            print(WordManager2.truelyCollected)
            for secLevel in WordManager2.similarListTotal {
                if w.text == secLevel[0] {
                    w.fontColor = .white
                    for thirdLevWord in (1 ..< (secLevel.count - 1)){
                        secWord1 = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
                        secWord1.text = secLevel[thirdLevWord]
                        secWord1.name = "round"
                        secWord1.fontSize = 10
                        secWord1.position = CGPoint(x: self.positions[index!][thirdLevWord].0, y: self.positions[index!][thirdLevWord].1)
                        if WordManager2.truelyCollected.contains(secLevel[thirdLevWord]) {
                            secWord1.fontColor = .white
                        } else {
                            secWord1.fontColor = UIColor(rgb: 0xF4D24F)
                        }
                        addChild(secWord1)
                    }
                }
                
            } 
        }
    }
    
    func addWrongWords() {
        var counter = 0
        for w in WordManager2.wrongTotal {
            wrongWord1 = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
            wrongWord1.text = w
            wrongWord1.name = "round"
            wrongWord1.fontSize = 12
            wrongWord1.fontColor = UIColor(rgb: 0xF54642)
            print(counter)
            wrongWord1.position = CGPoint(x: wrongPos[counter].0, y: wrongPos[counter].1)
            addChild(wrongWord1)
            counter += 1
        }
    }
}



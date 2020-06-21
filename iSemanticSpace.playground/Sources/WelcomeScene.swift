import SpriteKit
import PlaygroundSupport
import UIKit
import AVFoundation


public class WelcomeScene: SKScene, AVSpeechSynthesizerDelegate {
    
    var upperLabel = SKLabelNode()
    var midLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    var speechSynthesizer:AVSpeechSynthesizer!
    var tutorial: UIImage = #imageLiteral(resourceName: "1.png")
    var tutorialNode: SKSpriteNode!
    var tutorial2Node: SKSpriteNode!
    var tutorial3Node: SKSpriteNode!
    var tutorial4Node: SKSpriteNode!
    
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        arrangeSteve()
        background()
        arrangeSteveShadow()
        addBoard()
    }
    
    override public func didMove(to view: SKView) {
        speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.delegate = self
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(addTutorial), userInfo: nil, repeats: false)
        readText(forText: "OK! You learned cool things about NLP and specifically about semantic spaces. Before starts the game, let's look at the quick tutorial!",Int: 1)
        readText(forText: "Firstly, you should skip off words that are semantically far away from your word! You have just 5 HP for that.",Int: 2)
        readText(forText: "Secondly, there will be words that are semantically similar to your word. Try to take these words into your cart!",Int: 3)
        readText(forText: "At last but not least, Just enjoy! Natural Language is fun",Int: 4)
    }
    
    func background() {
        var background: UIImage = #imageLiteral(resourceName: "welcome.png")
        let backgroundTexture = SKTexture(image: background)
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.size = CGSize(width: 512, height: 512)
        backgroundNode.position = CGPoint(x: 256, y: 256)
        backgroundNode.name = "background"
        backgroundNode.zPosition = 0
        addChild(backgroundNode)
    }
    
    func addBoard() {
        
        let blue = SKShapeNode(rectOf: CGSize(width: 20, height: 140))
        blue.fillColor = UIColor(red: 0.4627, green: 0.7961, blue: 0.8863, alpha: 1.0)
        blue.strokeColor = UIColor(red: 0.4627, green: 0.7961, blue: 0.8863, alpha: 1.0)
        blue.position = CGPoint(x: 502, y: 422)
        blue.zPosition = 2
        addChild(blue)
        
        let board = SKShapeNode(rectOf: CGSize(width: 20, height: 140), cornerRadius: 5.0)
        board.fillColor = UIColor(rgb: 0x363636)
        board.strokeColor = UIColor(rgb: 0x42)
        board.position = CGPoint(x: 482, y: 422)
        board.zPosition = 2
        addChild(board)
        
        let paper = SKShapeNode(rectOf: CGSize(width: 350, height: 120), cornerRadius: 15.0)
        paper.fillColor = UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        paper.position = CGPoint(x: 702, y: 422)
        paper.zPosition = 1
        addChild(paper)
        
        let paperShadow = SKShapeNode(rectOf: CGSize(width: 350, height: 120), cornerRadius: 15.0)
        paperShadow.fillColor = UIColor(cgColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0))
        paperShadow.strokeColor = UIColor(cgColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0))
        paperShadow.position = CGPoint(x: 706, y: 419)
        paperShadow.zPosition = 0
        addChild(paperShadow)
        
        let moveShadow = SKAction.moveBy(x: -350, y: 0, duration: 2)
        let move = SKAction.moveBy(x: -350, y: 0, duration: 2)
        
        paper.run(move)
        paperShadow.run(moveShadow)
    }
    
    @objc func addTutorial() {
        let tutorialTexture = SKTexture(image: tutorial)
        tutorialNode = SKSpriteNode(texture: tutorialTexture)
        tutorialNode.size = CGSize(width: 250.2, height: 40)
        tutorialNode.position = CGPoint(x: 325, y: 422)
        tutorialNode.name = "tutorial"
        tutorialNode.zPosition = 3
        tutorialNode.alpha = 1
        addChild(tutorialNode)
        }
    
    func arrangeSteve() {
        var steveJobs: UIImage = #imageLiteral(resourceName: "steve-jobs-3884205_1920.png")
        let steve = SKTexture(image: steveJobs)
        let steveNode = SKSpriteNode(texture: steve)
        steveNode.size = CGSize(width: 400, height: 560)
        steveNode.position = CGPoint(x: 400, y: 100)
        steveNode.name = "steve"
        steveNode.zPosition = 1
        addChild(steveNode)
    }
    
    func arrangeSteveShadow() {
        var steveJobs: UIImage = #imageLiteral(resourceName: "steve-jobs-3884205_1920 copy.png")
        let steve = SKTexture(image: steveJobs)
        let steveNode = SKSpriteNode(texture: steve)
        steveNode.size = CGSize(width: 400, height: 560)
        steveNode.position = CGPoint(x: 405, y: 100)
        steveNode.name = "steve"
        steveNode.zPosition = 0
        addChild(steveNode)
    }
    func showTutorial(forInt: Int) {
        if forInt == 2 {
            var tutorial2: UIImage = #imageLiteral(resourceName: "2.png")
            let tutorial2Texture = SKTexture(image: tutorial2)
            tutorial2Node = SKSpriteNode(texture: tutorial2Texture)
            tutorial2Node.size = CGSize(width: 287, height: 40)
            tutorial2Node.position = CGPoint(x: 325, y: 422)
            tutorial2Node.name = "tutorial"
            tutorial2Node.zPosition = 3
            addChild(tutorial2Node)
            tutorialNode.alpha = 0
        } else if forInt == 3{
            var tutorial3: UIImage = #imageLiteral(resourceName: "3.png")
            let tutorial3Texture = SKTexture(image: tutorial3)
            tutorial3Node = SKSpriteNode(texture: tutorial3Texture)
            tutorial3Node.size = CGSize(width: 203, height: 40)
            tutorial3Node.position = CGPoint(x: 325, y: 422)
            tutorial3Node.name = "tutorial"
            tutorial3Node.zPosition = 3
            addChild(tutorial3Node)
            tutorial2Node.alpha = 0
        }else if forInt == 4 {
            var tutorial4: UIImage = #imageLiteral(resourceName: "4.png")
            let tutorial4Texture = SKTexture(image: tutorial4)
            tutorial4Node = SKSpriteNode(texture: tutorial4Texture)
            tutorial4Node.size = CGSize(width: 225, height: 40)
            tutorial4Node.position = CGPoint(x: 325, y: 422)
            tutorial4Node.name = "tutorial"
            tutorial4Node.zPosition = 3
            addChild(tutorial4Node)
            tutorial3Node.alpha = 0
        }
    }
    
    func readText(forText: String, Int: Int) {
        let voice = AVSpeechSynthesisVoice(language: "en-US")
        let speechUtterance = AVSpeechUtterance(string: forText)
        speechUtterance.voice = voice
        speechUtterance.postUtteranceDelay = 0.4
        speechUtterance.rate = 0.5
        speechUtterance.preUtteranceDelay = 0.0
        speechSynthesizer.speak(speechUtterance)
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finished utterance")
        if utterance.speechString == "OK! You learned cool things about NLP and specifically about semantic spaces. Before starts the game, let's look at the quick tutorial!" {
            showTutorial(forInt: 2)
        } else if utterance.speechString == "Firstly, you should skip off words that are semantically far away from your word! You have just 5 HP for that." {
            showTutorial(forInt: 3)
        } else if utterance.speechString == "Secondly, there will be words that are semantically similar to your word. Try to take these words into your cart!" {
            showTutorial(forInt: 4) }
        else if utterance.speechString == "At last but not least, Just enjoy! Natural Language is fun"  {
            var transition:SKTransition = SKTransition.fade(withDuration: 1)
            var scene:SKScene = BasketScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
    }
}

import SpriteKit
import AVFoundation

public class ChosingScene: SKScene, SKPhysicsContactDelegate{
    
    let userInput = UserInput.shared.word
    let wordManager = WordManager2()
    var dt: TimeInterval = 1.0
    var lastUpdateTime: TimeInterval = 1.0
    var round = 2
    var score = 0
    var health = 0
    var location = CGPoint(x: 0, y: 0)
    var defaultBasketPos:CGPoint!
    var basketNode:SKSpriteNode!
    var scoreLabel = SKLabelNode()
    var roundLabel = SKLabelNode()
    var healthLabel = SKLabelNode()
    var word = SKLabelNode()
    var wordIndex = 0
    var randomIndex = 1
    var countDownNode:SKLabelNode!
    var takeWord: [String] = []
    var backgroundWord: SKShapeNode!
    var actionMove:SKAction!
    var similarWord: [String] = []
    var wrongWord: [String] = []
    var lastWords: [String] = []
    var startFlag = 0
    var ggFlag = 0
    var restartNode: SKSpriteNode!
    var tryAgain = SKLabelNode()
    var givedWord: [SKShapeNode] = []
    var nextSceneIndicator = 0
    let FRWrongWords = WordManager2.wrongTotal
    var contentCreated = false
    let trueSound: SKAction = SKAction.playSoundFileNamed("true.mp3", waitForCompletion: false)
    let falseSound: SKAction = SKAction.playSoundFileNamed("false.wav", waitForCompletion: false)
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        background()
        startCountDown()
        scored()
        roundCurrent()
        healthCurrent()
        drawLines()
        createWord()
        addWalls()
    }
    
    override public func didMove(to view: SKView) {
        
        if lastWords.count != 0 {
            if startFlag == 1 {
                start()
            }
        }
    }
    
    func start() {
        let delay = SKAction.wait(forDuration: 1.5)
        let repeatingAction = SKAction.run(repeater)
        let sequence = SKAction.sequence([delay, repeatingAction])
        run(SKAction.repeatForever(sequence))
        
        self.physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
    }
    
    func startCountDown(){
        
        countDownNode = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        countDownNode.text = ""
        countDownNode.name = "round"
        countDownNode.fontSize = 40
        countDownNode.fontColor = UIColor(rgb: 0xF4D24F)
        countDownNode.position = CGPoint(x: 256 , y: 215)
        addChild(countDownNode)
        
        let leftIns = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        leftIns.text = "Now, choose words that similar to the words that you add your cart!"
        leftIns.fontSize = 15
        leftIns.fontColor = UIColor(rgb: 0xF4D24F)
        leftIns.alpha = 0
        leftIns.position = CGPoint(x: 256 , y: 280)
        addChild(leftIns)
        
        let rightIns = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        rightIns.text = "Be carefull about that and just tap!"
        rightIns.fontSize = 20
        rightIns.alpha = 0
        rightIns.fontColor = UIColor(rgb: 0xF4D24F)
        rightIns.position = CGPoint(x: 256 , y: 256)
        addChild(rightIns)
        countDownNode.alpha = 0
        
        var fadeOutAction = SKAction.fadeIn(withDuration: 1)
        fadeOutAction.timingMode = .easeInEaseOut
        
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "5"
            self.countDownNode.alpha = 1
            leftIns.alpha = 1
            rightIns.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 2)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "4"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 3)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "3"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 4)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "2"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 5)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "1"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 6)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "Go"
            self.countDownNode.alpha = 1
            leftIns.alpha = 0
            rightIns.alpha = 0
            self.startFlag = 1
            self.start()
        })
    }
    
    func background() {
        var background: UIImage = #imageLiteral(resourceName: "ikindi.jpg")
        let backgroundTexture = SKTexture(image: background)
        let backgroundNode = SKSpriteNode(texture: backgroundTexture)
        backgroundNode.size = CGSize(width: 512, height: 512)
        backgroundNode.position = CGPoint(x: 256, y: 256)
        backgroundNode.name = "background"
        backgroundNode.zPosition = 0
        addChild(backgroundNode)
    }
    
    func drawLines() {
        drawLine(rect: CGRect(x: 25, y: 452, width: 460, height: 40))
    }
    
    func drawLine(rect: CGRect) {
        let node = SKShapeNode(rect: rect, cornerRadius: 20)
        node.alpha = 0.4
        node.strokeColor = .black
        node.fillColor = .black
        node.zPosition = 1
        self.addChild(node)
    }
    
    func scored() {
        scoreLabel.text = "\(takeWord.count)"
        self.addChild(scoreLabel)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 20
        scoreLabel.zPosition = 2
        scoreLabel.fontName = "HelveticaNeue-Bold"
        scoreLabel.position = CGPoint(x: 50, y: height - 50)
    }
    
    func roundCurrent() {
        
        roundLabel.text = "Round" + " \(round)"
        self.addChild(roundLabel)
        roundLabel.fontColor = .white
        roundLabel.fontSize = 20
        roundLabel.zPosition = 2
        roundLabel.fontName = "HelveticaNeue-Bold"
        roundLabel.position = CGPoint(x: width/2, y: height - 50)
        
    }
    
    func healthCurrent() {
        
        health = 5
        healthLabel.text = "HP:" + " \(health)"
        self.addChild(healthLabel)
        healthLabel.fontSize = 20
        healthLabel.fontColor = .white
        healthLabel.zPosition = 2
        healthLabel.fontName = "HelveticaNeue-Bold"
        healthLabel.position = CGPoint(x: width - 65, y: height - 50)
        
    }
    
    func createWord() {
        
        // CorrectWords
        print(WordManager2.givingWords)
        similarWord = WordManager2.givingWords
        print(similarWord)
        //WrongWords
//          wordManager.deleteSimilarSpaces(forInput: similarWord)
        wrongWord = wordManager.createErrorWord()
        
        // last word update
        for i in similarWord {
            lastWords.append(i)
        }
        for i in wrongWord {
            lastWords.append(i)
        }
        
    }
    
    func giveWords() {
        
        let colorPalette = [0x2C9178, 0x0F2691, 0x249176, 0x43DEB7, 0x163ADE, 0xDE9543, 0x3E0F91, 0x2C913F, 0x8F2B75, 0x5D9023]
        
        let colorIndex = Int.random(in: 0 ..< (colorPalette.count - 1))
        
        let color = colorPalette[colorIndex]
        randomIndex = Int.random(in: 0 ..< lastWords.count)
        word = SKLabelNode(text: "\(lastWords[randomIndex])")
        lastWords.remove(at: randomIndex)
        word.fontSize = 17
        word.fontName = "HelveticaNeue-Bold"
        
        backgroundWord = SKShapeNode(rect: CGRect(x: 0, y: 0, width: (word.frame.width + 2), height: (word.frame.height + 3)), cornerRadius: 4)
        
        word.physicsBody? = SKPhysicsBody(rectangleOf: self.size)
        word.physicsBody?.collisionBitMask    = 0
        word.physicsBody?.contactTestBitMask  = 0
        word.physicsBody?.categoryBitMask     = 1
        word.physicsBody?.affectedByGravity = false
        word.physicsBody?.isDynamic = false
        word.name = "string word"
        word.position = CGPoint(x:(backgroundWord.position.x + word.frame.width/2 + 1 ), y: (backgroundWord.position.y) + 4)
        
        let x = Int.random(in: 1 ..< 9)
        let y = Int.random(in: 1 ..< 9)
        
        backgroundWord.position = CGPoint(x: (50 * x), y: (50 * y))
        backgroundWord.fillColor = UIColor(rgb: color)
        backgroundWord.strokeColor = UIColor(rgb: color)
        backgroundWord.name = "word"
        word.zPosition = 3
        backgroundWord.zPosition = 3
        backgroundWord.alpha = 0
        givedWord.append(backgroundWord)
        backgroundWord.addChild(word)
        addChild(backgroundWord)
        
    }
    
    func repeater() {
        if lastWords.count == 0 {
            return 
        }
        giveWords()
        countDownNode.alpha = 0
        
        var appear = SKAction.fadeIn(withDuration: 1)
        var wait = SKAction.wait(forDuration: 4)
        var disappear = SKAction.fadeOut(withDuration: 1)
        let together = SKAction.sequence([appear,wait ,disappear])
        backgroundWord.run(together)
        
        if (wordIndex + 1) < lastWords.count {
            wordIndex += 1
        } else {
            wordIndex = 0
        }  
    }
    
    func createSceneContents() {
        self.backgroundColor = .black
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func addWalls() {
        
        let wallRight = SKShapeNode(rectOf: CGSize(width: 3, height: 512))
        wallRight.fillColor = .black
        wallRight.strokeColor = .black
        wallRight.position = CGPoint(x: 510.5, y: 256)
        addChild(wallRight)
        
        let wallLeft = SKShapeNode(rectOf: CGSize(width: 3, height: 512))
        wallLeft.fillColor = .black
        wallLeft.strokeColor = .black
        wallLeft.position = CGPoint(x: 1.5, y: 256)
        addChild(wallLeft)
        
        let wallBottom = SKShapeNode(rectOf: CGSize(width: 512, height: 3))
        wallBottom.fillColor = .black
        wallBottom.strokeColor = .black
        wallBottom.position = CGPoint(x: 256, y: 1.5)
        addChild(wallBottom)
        
        let wallTop = SKShapeNode(rectOf: CGSize(width: 512, height: 3))
        wallTop.fillColor = .black
        wallTop.strokeColor = .black
        wallTop.position = CGPoint(x: 256, y: 510.5)
        addChild(wallTop)
        
    }
    
    override public func update(_ currentTime: CFTimeInterval) {
        if givedWord.count == 5 {
            let element = givedWord[0]
            givedWord.remove(at: 0)
            element.removeFromParent()
        }
        
        if lastWords.count == 0 {
            Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(nextScene), userInfo: nil, repeats: false)
        }
        if self.health == 0 {
            if ggFlag == 0 {
                gameOver()
                ggFlag += 1
            }
        }
        
    }
    
    @objc func nextScene() {
        if nextSceneIndicator == 0 {
            var transition:SKTransition = SKTransition.fade(withDuration: 0.1)
            var scene:SKScene = BrewingScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            nextSceneIndicator = -1
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        for touch in touches {
            let location = touch.location(in: self)
            for check in givedWord {
                if check.contains(location) {
                    if let word = check.childNode(withName: "string word") as? SKLabelNode {
                        if self.similarWord.contains(word.text!) {
                            WordManager2.truelyCollected.append(word.text!)
                            self.score += 1
                            self.scoreLabel.text = "\(self.score)"
                            self.takeWord.append(word.text!)
                            self.run(self.trueSound)
                            SSManager.shared.firstWords.append(word.text!)
                            word.removeFromParent()
                            check.removeFromParent()
                        } else {
                            self.run(self.falseSound)
                            self.health -= 1
                            self.healthLabel.text = "HP: \(self.health)"
                            WordManager2.wrongTotal.append(word.text!)
                            word.removeFromParent()
                            check.removeFromParent()
                        }
                    }
                }
            }
        }
        
        if restartNode != nil {
            
            let touch = touches.first?.location(in: self)
            if restartNode.frame.contains(touch!) {
                restartNode.alpha = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    self.restartNode.alpha = 1.0
                    var transition:SKTransition = SKTransition.fade(withDuration: 0.1)
                    var scene:SKScene = ChosingScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func gameOver() {
        
        let gameOver = SKShapeNode(rectOf: CGSize(width: 384, height: 384), cornerRadius: 20)
        gameOver.fillColor = .black
        gameOver.zPosition = 6
        gameOver.alpha = 0.7
        gameOver.position = CGPoint(x: 256, y: 256)
        addChild(gameOver)
        self.scene?.isPaused = true
        
        WordManager2.truelyCollected = []
        WordManager2.wrongTotal = FRWrongWords
        
        var restart: UIImage = #imageLiteral(resourceName: "restart.png")
        let restartTexture = SKTexture(image: restart)
        restartNode = SKSpriteNode(texture: restartTexture)
        restartNode.size = CGSize(width: 64, height: 64)
        restartNode.position = CGPoint(x: 256, y: 256)
        restartNode.name = "background"
        restartNode.zPosition = 7
        addChild(restartNode)
        
        tryAgain.text = "Try Again !"
        self.addChild(tryAgain)
        tryAgain.fontColor = .white
        tryAgain.fontSize = 17
        tryAgain.zPosition = 7
        tryAgain.fontName = "HelveticaNeue-Bold"
        tryAgain.position = CGPoint(x: 256, y: 180)
        
    }
}


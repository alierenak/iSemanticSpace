import SpriteKit
import AVFoundation

public class BasketScene: SKScene, SKPhysicsContactDelegate{
    
    let userInput = UserInput.shared.word
    let wordManager = WordManager()
    var dt: TimeInterval = 1.0
    var lastUpdateTime: TimeInterval = 1.0
    var round = 1
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
    var wordCount: Int = 0
    var startFlag = 0
    var ggFlag = 0
    var restartNode: SKSpriteNode!
    var tryAgain = SKLabelNode()
    var nextWords = WordManager2()
    var player: AVAudioPlayer?
    public static var givedWordList: [String] = []
    public static let shared = BasketScene()
    
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
        addBasket()
        createWord()
    }
    
    override public func didMove(to view: SKView) {
        
        if lastWords.count != 0 {
            if startFlag == 1 {
                start()
            }
        }
    }
    
    func start() {
        let delay = SKAction.wait(forDuration: 2)
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
        countDownNode.position = CGPoint(x: 256 , y: 256)
        addChild(countDownNode)
        
        let leftIns = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        leftIns.text = "Tap here for left"
        leftIns.fontSize = 20
        leftIns.fontColor = UIColor(rgb: 0xF4D24F)
        leftIns.alpha = 0
        leftIns.position = CGPoint(x: 128 , y: 256)
        addChild(leftIns)
        
        let rightIns = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        rightIns.text = "Tap here for right"
        rightIns.fontSize = 20
        rightIns.alpha = 0
        rightIns.fontColor = UIColor(rgb: 0xF4D24F)
        rightIns.position = CGPoint(x: 384 , y: 256)
        addChild(rightIns)
        countDownNode.alpha = 0
        
        var fadeOutAction = SKAction.fadeIn(withDuration: 1)
        fadeOutAction.timingMode = .easeInEaseOut
        
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "3"
            self.countDownNode.alpha = 1
            leftIns.alpha = 1
            rightIns.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 2)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "2"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 3)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "1"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 4)
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
        var background: UIImage = #imageLiteral(resourceName: "Screen Shot 2020-05-16 at 01.10.40.png")
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
        node.fillColor = .white
        node.alpha = 0.8
        node.strokeColor = .white
        node.zPosition = 1
        self.addChild(node)
    }
    
    func scored() {
        scoreLabel.text = "\(takeWord.count)"
        self.addChild(scoreLabel)
        scoreLabel.fontColor = UIColor(rgb: 0xF4D24F)
        scoreLabel.fontSize = 20
        scoreLabel.zPosition = 2
        scoreLabel.fontName = "HelveticaNeue-Bold"
        scoreLabel.position = CGPoint(x: 50, y: height - 50)
    }
    
    func roundCurrent() {
        
        round = 1
        roundLabel.text = "Round" + " \(round)"
        self.addChild(roundLabel)
        roundLabel.fontColor = UIColor(rgb: 0xF4D24F)
        roundLabel.fontSize = 20
        roundLabel.zPosition = 2
        roundLabel.fontName = "HelveticaNeue-Bold"
        roundLabel.position = CGPoint(x: width/2, y: height - 50)
        
    }
    
    func healthCurrent() {
        
        health = 3
        healthLabel.text = "HP:" + " \(health)"
        self.addChild(healthLabel)
        healthLabel.fontSize = 20
        healthLabel.fontColor = UIColor(rgb: 0xF4D24F)
        healthLabel.zPosition = 2
        healthLabel.fontName = "HelveticaNeue-Bold"
        healthLabel.position = CGPoint(x: width - 65, y: height - 50)
        
    }
    
    func createWord() {
        
        // CorrectWords
        if wordManager.checkInput(forInput: userInput) {
            similarWord = wordManager.createGiveSimilar(forInput: userInput)
        } else {
            print("Oww man! Please choose basic english word! Do you want to create beatiful semantic space? You could not create it with *\(userInput)*")
        }
        
        //WrongWords
        wordManager.deleteSimilarSpaces(forInput: userInput)
        wrongWord = wordManager.createErrorWord()
        
        // last word update
        for i in similarWord {
            lastWords.append(i)
        }
        for i in wrongWord {
            lastWords.append(i)
        }
        wordCount = lastWords.count
        for i in lastWords {
            BasketScene.givedWordList.append(i)
        }
        
    }
    
    func giveWords() {
        
        let colorPalette = [0x92A1DE, 0xDEAD9E, 0xDEC271, 0x7CDEC4, 0xDE92A2, 0xD487DE, 0x9D7CDE, 0xC3DEA9, 0xDE92A1, 0xDEBE9E]
        
        let colorIndex = Int.random(in: 0 ..< (colorPalette.count - 1))
        
        let color = colorPalette[colorIndex]
        randomIndex = Int.random(in: 0 ..< lastWords.count)
        word = SKLabelNode(text: "\(lastWords[randomIndex])")
        lastWords.remove(at: randomIndex)
        wordCount += -1
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
        
        let number = Int.random(in: 1 ..< 9)
        backgroundWord.position = CGPoint(x: (50 * number), y: 430)
        backgroundWord.fillColor = UIColor(rgb: color)
        backgroundWord.strokeColor = UIColor(rgb: color)
        backgroundWord.name = "word"
        word.zPosition = 3
        backgroundWord.zPosition = 3
        backgroundWord.addChild(word)
        addChild(backgroundWord)
        
    }
    
    func repeater() {
        if lastWords.count == 0 {
            return 
        }
        giveWords()
        countDownNode.alpha = 0
        var moveTestShape = SKAction.moveBy(x: 0, y: -650, duration: 6)
        backgroundWord.run(moveTestShape, withKey: "speed")
        
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
    
    func addBasket() {
        
        var basket: UIImage = #imageLiteral(resourceName: "cart.png")
        let basketTexture = SKTexture(image: basket)
        basketNode = SKSpriteNode(texture: basketTexture)
        basketNode.size = CGSize(width: 120, height: 78.82)
        
        defaultBasketPos = CGPoint(x:frame.midX, y:basketNode.frame.height/2)
        basketNode.position = defaultBasketPos
        basketNode.name = "basket"
        basketNode.zPosition = 3
        
        basketNode.physicsBody = SKPhysicsBody(rectangleOf: basketNode.size)
        basketNode.physicsBody?.collisionBitMask    = 1
        basketNode.physicsBody?.contactTestBitMask  = 1
        basketNode.physicsBody?.categoryBitMask     = 0
        basketNode.physicsBody?.affectedByGravity = false
        basketNode.physicsBody?.isDynamic = true
        addChild(basketNode)
        
    }
    
    override public func update(_ currentTime: CFTimeInterval) {
        
        checkCollision()
        
        if wordCount == 0 {
            // toplanan kelimeler == 0 ise gameover()
            Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(nextScene), userInfo: nil, repeats: false)
            wordCount = -1
            
        }
        if self.health == 0 {
            if ggFlag == 0 {
                gameOver()
                ggFlag += 1
            }
        }
        
    }
    
    @objc func nextScene() {
        
        var transition:SKTransition = SKTransition.fade(withDuration: 0.1)
        var scene:SKScene = ChosingScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if basketNode != nil {
            
            let touch = touches.first?.location(in: self)
            if (touch?.x)! > basketNode.position.x {
                let moveAction = SKAction.moveBy(x: 30, y: 0, duration: 0.1)
                let repeatForEver = SKAction.repeatForever(moveAction)
                let seq = SKAction.sequence([moveAction, repeatForEver])
                basketNode.run(seq)
            
            }else{
                let moveAction = SKAction.moveBy(x: -30, y: 0, duration: 0.1)
                let repeatForEver = SKAction.repeatForever(moveAction)
                let seq = SKAction.sequence([moveAction, repeatForEver])
                basketNode.run(seq)
            }
        }
        
        if restartNode != nil {
            
            let touch = touches.first?.location(in: self)
            if restartNode.frame.contains(touch!) {
                restartNode.alpha = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    self.restartNode.alpha = 1.0
                var transition:SKTransition = SKTransition.fade(withDuration: 0.05)
                var scene:SKScene = BasketScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        basketNode.removeAllActions()
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
        
    }
    
    func checkCollision() {
        
        enumerateChildNodes(withName: "word") { (node, _) in
            let background = node as! SKShapeNode
            if self.basketNode.frame.intersects(background.frame) {
                if let word = background.childNode(withName: "string word") as? SKLabelNode {
                    if self.similarWord.contains(word.text!) {
                        self.score += 1
                        self.scoreLabel.text = "\(self.score)"
                        self.nextWords.createGiveSimilarLists(forInput: word.text!)
                        self.run(self.trueSound)
                        word.removeFromParent()
                        background.removeFromParent()
                    } else {
                        self.run(self.falseSound)
                        self.health -= 1
                        self.healthLabel.text = "HP: \(self.health)"
                        WordManager2.wrongTotal.append(word.text!)
                        word.removeFromParent()
                        background.removeFromParent()
                    }
                }
            }
        }
    }
    
    func gameOver() {
        let gameOver = SKShapeNode(rectOf: CGSize(width: 384, height: 384), cornerRadius: 20)
        gameOver.fillColor = .black
        gameOver.zPosition = 6
        gameOver.alpha = 0.7
        gameOver.position = CGPoint(x: 256, y: 256)
        addChild(gameOver)
        self.scene?.isPaused = true
        
        WordManager2.givingWords = []
        WordManager2.similarListTotal = []
        WordManager2.wrongTotal = []
        
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


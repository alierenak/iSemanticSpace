
import NaturalLanguage

public class WordManager2 {
    
    let upperLimit = 1.15
    let lowerLimit = 0.85
    let embedding = NLEmbedding.wordEmbedding(for: .english)
    var nonSimilar: [String] = []
    
    public static var wrongTotal: [String] = []
    public static var similarListTotal: [[String]] = []
    public static var givingWords: [String] = []
    public static var truelyCollected: [String] = []
    
    var flag = 0
    public static let shared = WordManager2()
    
    public func createGiveSimilarLists(forInput: String) {
        var list: [String] = []
        list.append(forInput)
        var count: Int = 5
        let similarWords = embedding?.neighbors(for: forInput, maximumCount: count)
        for i in similarWords! {
            if WordManager2.givingWords.contains(i.0) {
                print("Already added")
            }else if BasketScene.givedWordList.contains(i.0) || i.0 == UserInput.shared.word {
                print("Similar with first ones")
            }
            else {
                WordManager2.givingWords.append(i.0)
                list.append(i.0)
            }
        }
        if list.count != 0 {
            WordManager2.similarListTotal.append(list)
        }
    }
    
    public func createErrorWord() -> [String] {
        let upperLimit = 40 - (WordManager2.givingWords.count)
        while flag < upperLimit {
            let number = Int.random(in: 0 ..< (WordManager.mySemanticSpace.count - 1))
            let word = WordManager.mySemanticSpace[number]
            let possibleWord = embedding?.neighbors(for: word, maximumCount: 50)
            let number2 = Int.random(in: 0 ..< 50)
            let lastWord = possibleWord![number2].0
            nonSimilar.append(lastWord)
            flag += 1
        }
        return nonSimilar
    }
}

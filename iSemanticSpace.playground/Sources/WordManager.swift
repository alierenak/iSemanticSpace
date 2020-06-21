import NaturalLanguage

public class WordManager {
    
    let upperLimit = 1.15
    let lowerLimit = 0.85
    let embedding = NLEmbedding.wordEmbedding(for: .english)
    public static var giveSimilar: [String] = []
    var nonSimilar: [String] = []
    var flag = 0

    
    public static var mySemanticSpace = ["animal", "insect", "athletes", "talk", "text", "shape", "activity", "people", "road", "clothing", "material", "building", "tool", "vehicle", "furniture", "device", "bird", "reptiles", "places", "biology", "travel", "person", "fruit", "food", "computer", "science", "technology", "environment", "organ", "swift"]
    
    public func checkInput(forInput: String) -> Bool {
        var flag: Bool = false
        let similarWords = embedding?.neighbors(for: forInput, maximumCount: 10)
        let similarWordCount = similarWords?.count
        if similarWordCount! < 10 {
            print("Oww man! Please choose basic english word! Do you want to create beatiful semantic space? You could not create it with *\(forInput)*")
            flag = false
        } else {
            flag = true
        }
        return flag
    }
    
    public func createGiveSimilar(forInput: String) -> [String] {
        WordManager.giveSimilar = []
        let similarWords = embedding?.neighbors(for: forInput, maximumCount: 5)
        for i in similarWords! {
            WordManager.giveSimilar.append(i.0)
        }
        return WordManager.giveSimilar
    }
    
    public func deleteSimilarSpaces(forInput: String) {
        for i in WordManager.mySemanticSpace {
            let distance = embedding?.distance(between: forInput, and: i)
            if distance!.isLess(than: upperLimit) && lowerLimit.isLess(than: distance!) {
                let indeX = WordManager.mySemanticSpace.firstIndex(of: i)
                WordManager.mySemanticSpace.remove(at: indeX!)
            }
        }
    }
    
    public func createErrorWord() -> [String] {
        while flag < 10 {
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

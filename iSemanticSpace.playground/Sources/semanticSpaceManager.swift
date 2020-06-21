import Foundation

public class SSManager {
    var wordManager = WordManager2()
    public var baseWord: String = UserInput.shared.word
    public var firstWords: [String] = []
    public var firstWrongs: [String] = []
    public var secondWords: [String] = []
    public static let shared = SSManager()
}

import XCTest
@testable import MiniCrossword

final class MiniCrosswordTests: XCTestCase {
    func testCrosswordInitialization() {
        let crosswordData = CrosswordData(
            verticalWords: [["М", "О", "Л", "Ь"], ["Л", "У", "Ж", "А"]],
            horizontalWords: [["Л", "О", "Ж", "К", "А"]],
            intersectionLetters: [
                CGPoint(x: 2, y: 1): "Л",
                CGPoint(x: 2, y: 3): "Ж"
            ],
            questions: [
                "1. Чем едят суп? (гориз. 1)",
                "2. Насекомое, которое ест одежду? (верт. 1)",
                "3. Что остается после дождя? (верт. 2)"
            ],
            cellColor: .blue
        )
        
        let crosswordVC = CrosswordViewController(crosswordData: crosswordData)
        XCTAssertNotNil(crosswordVC)
        XCTAssertEqual(crosswordVC.crosswordData.verticalWords.count, 2)
        XCTAssertEqual(crosswordVC.crosswordData.horizontalWords.count, 1)
    }
}


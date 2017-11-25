import XCTest
@testable import CircularQueue

class CircularQueueTests: XCTestCase {
    func testValues() {
        let values = [1, 2, 3, 4, 5, 6, 7, 8]
        let n = values.count
        let queue = CircularQueue<Int>(capacity: n)
        values.forEach(queue.enqueue)
        XCTAssertEqual(queue.count, n)
        XCTAssertEqual(queue.readIndex, 0)
        for i in 0..<n {
            let k = n - i
            XCTAssertEqual(queue.count, k)
            let x = queue.dequeue()
            XCTAssertEqual(x, values[i])
            XCTAssertEqual(queue.count, k-1)
        }
    }


    static var allTests = [
        ("testValues", testValues),
    ]
}

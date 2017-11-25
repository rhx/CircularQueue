/// Fixed-capacity circular queue
public class CircularQueue<T> {
    var count: Int = 0
    var readIndex: Int = 0
    let storageBase: UnsafeMutablePointer<T>

    /// maximum capacity of the queue
    public let capacity: Int

    /// Create a circular queue with a given capacity
    ///
    /// - Parameter n: number of elements that fit into the queue
    public init(capacity n: Int) {
        capacity = n
        storageBase = UnsafeMutablePointer<T>.allocate(capacity: n)
    }

    deinit {
        storageBase.deallocate(capacity: capacity)
    }

    /// Append an element to the end of the queue
    ///
    /// - Parameter element: the element to append
    public func enqueue(_ element: T) {
        precondition(count < capacity)
        let offset = readIndex + count
        let i = offset < capacity ? offset : offset - capacity
        storageBase[i] = element
        count += 1
    }

    /// Retrieve an element, removing it from the queue
    ///
    /// - Returns: the oldest element that was put into the queue
    public func dequeue() -> T {
        precondition(count > 0)
        defer {
            readIndex += 1
            if readIndex >= capacity { readIndex -= capacity }
        }
        return storageBase[readIndex]
    }
}

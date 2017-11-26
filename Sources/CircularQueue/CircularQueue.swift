/// Fixed-capacity circular queue
public class CircularQueue<T> {
    var count: Int = 0
    var readIndex: Int = 0
    var storage: ContiguousArray<T>

    /// maximum capacity of the queue
    public let capacity: Int

    /// Create a circular queue with a given capacity
    ///
    /// - Parameter n: number of elements that fit into the queue
    public init(capacity n: Int) {
        storage = ContiguousArray()
        storage.reserveCapacity(n)
        capacity = n
    }

    /// Append an element to the end of the queue
    ///
    /// - Parameter element: the element to append
    public func enqueue(_ element: T) {
        precondition(count < capacity)
        let offset = readIndex + count
        let i = offset < capacity ? offset : offset - capacity
        let n = storage.count
        if i < n {
            storage[i] = element
        } else {
            assert(i == n)
            storage.append(element)
        }
        count += 1
    }

    /// Retrieve an element, removing it from the queue
    ///
    /// - Returns: the oldest element that was put into the queue
    public func dequeue() -> T {
        precondition(count > 0)
        count -= 1
        defer {
            readIndex += 1
            if readIndex >= capacity { readIndex -= capacity }
        }
        return storage[readIndex]
    }
}

import Foundation

public final class Elevator {
    
    var floor: Floor?
    
    var isEmpty: Bool {
      return floor == nil
    }
    
    var first: Floor? {
      return floor
    }
    
    var last: Floor? {
      guard var node = floor else { return nil }
      
      while let next = node.next {
        node = next
      }
      return node
    }
    
    var count: Int {
      guard var node = floor else { return 0 }
      
      var count = 1
      
      while let next = node.next {
        node = next
        count += 1
      }
      return count
    }
    
    init() {}
    
    func append(_ node: Floor) {
      if last != nil {
        last?.next = node
        node.previous = last
      } else {
        floor = node
      }
    }
    
    func printAll() {
        guard var node = floor else { print("Empty"); return }
        print(node.debugDescription)
        while let next = node.next {
            print(next.debugDescription)
          node = next
        }
    }
}

final class ScreenPoints {
  fileprivate let a: Double
  fileprivate let b: Double
  fileprivate let c: Double
  fileprivate let d: Double
  fileprivate let points: [Point]

  init(world: Rectangle, screenSpace: Rectangle, points: [Point]) {
    self.points = points

    a = (screenSpace.right - screenSpace.left) / (world.right - world.left)
    b = (screenSpace.top - screenSpace.bottom) / (world.top - world.bottom)
    c = screenSpace.left - a * world.left
    d = screenSpace.bottom - b * world.bottom
  }
}

extension ScreenPoints: Sequence {
  var count: Int {
    return points.count
  }

  final class ScreenPointsIterator: IteratorProtocol {
    private let screenPoints: ScreenPoints
    private var index = 0

    init(screenPoints: ScreenPoints) {
      self.screenPoints = screenPoints
    }

    func next() -> Point? {
      guard index < screenPoints.count else { return nil }
      let next = screenPoints[index]
      let x = screenPoints.a * next.x + screenPoints.c
      let y = screenPoints.b * next.y + screenPoints.d
      index += 1
      return Point(x: x, y: y)
    }
  }

  func makeIterator() -> ScreenPointsIterator {
    return ScreenPointsIterator(screenPoints: self)
  }

  subscript(index: Int) -> Point {
    return points[index]
  }
}

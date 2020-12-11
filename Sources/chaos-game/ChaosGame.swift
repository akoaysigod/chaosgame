final class ChaosGame {
  private static let maxIteration = 100_000
  private static let ignoreFirst = 10

  private let regularPolygon: RegularPolygon
  private var lastPoint: Point
  private var lastVertex = 0
  private let ratio: Double
  private let distance: Int
  private let function: (Int, Int, Int) -> Bool

  init(regularPolygon: RegularPolygon,
       ratio: Double,
       distance: Int,
       function: @escaping (Int, Int, Int) -> Bool) {
    self.regularPolygon = regularPolygon
    self.ratio = ratio
    self.distance = distance
    self.function = function

    lastPoint = regularPolygon[0]
  }

  static func new(choice: Int) -> ChaosGame {
    let nrEdges: Int
    let ratio: Double
    let distance: Int
    let alwaysTrue: (Int, Int, Int) -> Bool = { _, _, _ in return true }
    let absolute: (Int, Int, Int) -> Bool = { randomVertex, lastVertex, distance in
      return abs(randomVertex - lastVertex) != distance
    }
    let function: (Int, Int, Int) -> Bool

    switch choice {
    case 0:
      nrEdges = 3
      ratio = 0.5
      distance = 0
      function = alwaysTrue
    case 1:
      nrEdges = 4
      ratio = 0.5
      distance = 0
      function = absolute
    case 2:
      nrEdges = 4
      ratio = 0.5
      distance = 2
      function = absolute
    case 3:
      nrEdges = 5
      ratio = 0.5
      distance = 0
      function = absolute
    case 4:
      nrEdges = 7
      ratio = 0.4
      distance = 0
      function = alwaysTrue
    case 5:
      nrEdges = 7
      ratio = 0.4
      distance = 3
      function = absolute
    case 6:
      nrEdges = 6
      ratio = 0.4
      distance = 3
      function = absolute
    case 7:
      nrEdges = 6
      ratio = 0.375
      distance = 0
      function = absolute
    case 8:
      nrEdges = 6
      ratio = 0.5
      distance = 0
      function = absolute
    case 9:
      nrEdges = 8
      ratio = 0.4
      distance = 0
      function = absolute
    case 10:
      nrEdges = 10
      ratio = 0.375
      distance = 1
      function = absolute
    case 11:
      nrEdges = 10
      ratio = 0.375
      distance = 2
      function = absolute
    case 12:
      nrEdges = 10
      ratio = 0.375
      distance = 3
      function = absolute
    case 13:
      nrEdges = 10
      ratio = 0.375
      distance = 4
      function = absolute
    case 14:
      nrEdges = 10
      ratio = 0.375
      distance = 5
      function = absolute
    case _:
      fatalError("\(choice) must be >= 0 and <= 14")
    }
    return ChaosGame(
      regularPolygon: RegularPolygon(nrEdges: nrEdges),
      ratio: ratio,
      distance: distance,
      function: function
    )
  }

  private func getNextPoint() -> Point {
    var removedIterations = 0
    while true {
      let randomVertex = Int.random(in: 0..<regularPolygon.count)
      guard function(randomVertex, lastVertex, distance) else { continue }
      let x = (lastPoint.x + regularPolygon[randomVertex].x) * ratio
      let y = (lastPoint.y + regularPolygon[randomVertex].y) * ratio
      lastVertex = randomVertex
      lastPoint = Point(x: x, y: y)
      removedIterations += 1
      guard removedIterations >= ChaosGame.ignoreFirst else { continue }
      return lastPoint
    }
  }

  func generatePoints() -> [Point] {
    return (0..<ChaosGame.maxIteration).map { _ in
      return getNextPoint()
    }
  }
}

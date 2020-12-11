import Darwin

final class RegularPolygon {
  private let nrEdges: Int
  private let radius: Double
  private let startAngle: Double
  private let angle: Double
  fileprivate let points: [Point]

  var count: Int {
    return points.count
  }

  init() {
    nrEdges = 3
    radius = 1.0
    startAngle = 90.0
    angle = 120.0
    points = RegularPolygon.generatePoints(startAngle: startAngle,
                                           angle: angle,
                                           nrEdges: nrEdges,
                                           radius: radius)
  }

  init(nrEdges: Int, radius: Double = 1.0) {
    self.nrEdges = nrEdges
    self.radius = radius
    angle = 360.0 / Double(nrEdges)
    let startAngle = 90.0
    self.startAngle = nrEdges % 2 == 0 ?
      startAngle + (angle / 2.0) :
      startAngle
    points = RegularPolygon.generatePoints(startAngle: startAngle,
                                           angle: angle,
                                           nrEdges: nrEdges,
                                           radius: radius)
  }

  private static func generatePoints(startAngle: Double,
                                     angle: Double,
                                     nrEdges: Int,
                                     radius: Double) -> [Point] {
    let degreeRadians = Double.pi / 180.0
    var currentAngle = startAngle * degreeRadians
    var minY = 2.0
    var points = [Point](repeating: Point(x: 0, y: 0), count: nrEdges)
    for i in (0..<nrEdges) {
      let x = radius * cos(currentAngle)
      let y = radius * sin(currentAngle)
      if minY > y {
        minY = y
      }
      points[i] = Point(x: x, y: y)
      currentAngle += angle * degreeRadians
    }

    let offset = (2.0 - (1.0 - minY)) / 2.0
    guard nrEdges % 2 != 0 else { return points }
    for i in (0..<nrEdges) {
      let point = points[i]
      let y = point.y - offset
      points[i] = Point(x: point.x, y: y)
    }
    return points
  }

  subscript(index: Int) -> Point {
    return points[index]
  }
}

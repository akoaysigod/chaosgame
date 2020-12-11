import SDL
import Metal

func main(height: Int32, width: Int32) {
  let world = Rectangle(left: -1.08, bottom: -1.08, right: 1.08, top: 1.08)
  let screenSpace = Rectangle(left: 0,
                              bottom: Double(height - 1),
                              right: Double(width - 1),
                              top: 0)

  let points = ChaosGame.new(choice: 0).generatePoints()
  let screenPoints = ScreenPoints(world: world,
                                  screenSpace: screenSpace,
                                  points: points)
  let sdlRunLoop = SDLRunLoop(screenPoints: screenPoints)
  sdlRunLoop.run()

  let device = MTLCreateSystemDefaultDevice()
}

main(height: 800, width: 800)

import SDL

final class SDLRunLoop {
  private var points: [SDL_Point]
  private let sdl = SDL()

  init(screenPoints: ScreenPoints) {
    self.points = screenPoints.map { point in
      return SDL_Point(x: Int32(point.x), y: Int32(point.y))
    }
  }

  func run() {
    _run()
    sdl.quit()
  }

  private func _run() {
    let window = SDLWindow(name: "Chaos game", x: 0, y: 0, width: 800, height: 800)
    let renderer = SDLRenderer(sdlWindow: window)

    var isRunning = true
    var event = SDL_Event()
    while isRunning {
      SDL_PollEvent(&event)

      let eventType = SDL_EventType(rawValue: event.type)
      switch eventType {
      case SDL_QUIT:
        isRunning = false
      case _:
        break
      }

      switch event.key.keysym.sym {
      case Int32(SDLK_ESCAPE):
      isRunning = false
      case _:
        break
      }

      renderer.present(points: &points)
    }
  }
}

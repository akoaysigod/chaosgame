import SDL

final class SDLRenderer {
  private let renderer: OpaquePointer

  init(sdlWindow: SDLWindow) {
    renderer = SDL_CreateRenderer(
      sdlWindow.window,
      -1,
      SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue
    )
  }

  deinit {
    SDL_DestroyRenderer(renderer)
  }

  func present(points: inout [SDL_Point]) {
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255)
    SDL_RenderClear(renderer)
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255)

    SDL_RenderDrawPoints(renderer, &points, Int32(points.count))

    SDL_RenderPresent(renderer)
  }
}

import SDL

final class SDLWindow {
  let window: OpaquePointer

  init(name: String, x: Int32, y: Int32, width: Int32, height: Int32) {
    window = SDL_CreateWindow(
      "Choas game",
      0,
      0,
      height,
      width,
      SDL_WINDOW_SHOWN.rawValue)
  }

  deinit {
    SDL_DestroyWindow(window)
  }
}

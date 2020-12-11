import SDL

final class SDL {
  init() {
    SDL_Init(SDL_INIT_VIDEO)
  }

  func quit() {
    SDL_Quit()
  }
}

require "../sdl"

module Game
  def self.quit
    SDL.quit
  end

  def self.poll
    SDL.poll_events do |event|
      yield SDL::Event.new(event)
    end
  end

  def self.exit_on_event!
    Game.poll do |event|
      if event.quit?
        Game.quit
        exit
      end
    end
  end

  def self.go(width = 640, height = 480)
    # TODO: SDL.init is just a wrapper around LibSDL.init.. so just
    # replace it with the original statement!
    SDL.init
    # TODO: Same as above.
    SDL.show_cursor

    screen = SDL.set_video_mode width, height, 32, LibSDL::DOUBLEBUF | LibSDL::HWSURFACE | LibSDL::ASYNCBLIT

    if screen.nil?
      raise "Couldn't create window for SDL!"
    end

    loop do
      yield screen
      screen.flip
    end
  end
end

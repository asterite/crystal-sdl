
lib LibSDL("SDL")
  INIT_TIMER       = 0x00000001_u32
  INIT_AUDIO       = 0x00000010_u32
  INIT_VIDEO       = 0x00000020_u32
  INIT_CDROM       = 0x00000100_u32
  INIT_JOYSTICK    = 0x00000200_u32
  INIT_NOPARACHUTE = 0x00100000_u32
  INIT_EVENTTHREAD = 0x01000000_u32
  INIT_EVERYTHING  = 0x0000FFFF_u32

  SWSURFACE = 0x00000000_u32
  HWSURFACE = 0x00000001_u32
  ASYNCBLIT = 0x00000004_u32

  ANYFORMAT  = 0x10000000_u32
  HWPALETTE  = 0x20000000_u32
  DOUBLEBUF  = 0x40000000_u32
  FULLSCREEN = 0x80000000_u32
  OPENGL     = 0x00000002_u32
  OPENGLBLIT = 0x0000000A_u32
  RESIZABLE  = 0x00000010_u32
  NOFRAME    = 0x00000020_u32

  NOEVENT         =  0_u8
  ACTIVEEVENT     =  1_u8
  KEYDOWN         =  2_u8
  KEYUP           =  3_u8
  MOUSEMOTION     =  4_u8
  MOUSEBUTTONDOWN =  5_u8
  MOUSEBUTTONUP   =  6_u8
  JOYAXISMOTION   =  7_u8
  JOYBALLMOTION   =  8_u8
  JOYHATMOTION    =  9_u8
  JOYBUTTONDOWN   = 10_u8
  JOYBUTTONUP     = 11_u8
  QUIT            = 12_u8
  SYSWMEVENT      = 13_u8
  EVENT_RESERVEDA = 14_u8
  EVENT_RESERVEDB = 15_u8
  VIDEORESIZE     = 16_u8
  VIDEOEXPOSE     = 17_u8
  EVENT_RESERVED2 = 18_u8
  EVENT_RESERVED3 = 19_u8
  EVENT_RESERVED4 = 20_u8
  EVENT_RESERVED5 = 21_u8
  EVENT_RESERVED6 = 22_u8
  EVENT_RESERVED7 = 23_u8
  USEREVENT       = 24_u8
  NUMEVENTS       = 32_u8

  HWACCEL     = 0x00000100_u32
  SRCCOLORKEY = 0x00001000_u32
  RLEACCELOK  = 0x00002000_u32
  RLEACCEL    = 0x00004000_u32
  SRCALPHA    = 0x00010000_u32
  PREALLOC    = 0x01000000_u32

  DISABLE = 0
  ENABLE = 1

  struct Color
    r, g, b, unused : UInt8
  end

  struct Rect
    x, y : Int16
    w, h : UInt16
  end

  struct Palette
    ncolors : Int32
    colors : Color*
  end

  struct PixelFormat
    palette : Palette*
    bitspp  : UInt8
    bytespp : UInt8
    rloss, gloss, bloss, aloss : UInt8
    rshift, gshift, bshift, ashift : UInt8
    rmask, gmask, bmask, amask : UInt8
    colorkey : UInt32
    alpha : UInt8
  end

  struct Surface
    flags : UInt32
    format : PixelFormat* #TODO
    w, h : Int32
    pitch : UInt16
    pixels : Void*
    #TODO
  end

  struct Version
    major : UInt8
    minor : UInt8
    patch : UInt8
  end

  enum Key
    ESCAPE = 27
    A = 97
    B = 98
    C = 99
    D = 100
    E = 101
    F = 102
    G = 103
    H = 104
    I = 105
    J = 106
    K = 107
    L = 108
    M = 109
    N = 110
    O = 111
    P = 112
    Q = 113
    R = 114
    S = 115
    T = 116
    U = 117
    V = 118
    W = 119
    X = 120
    Y = 121
    Z = 122
    UP = 273
    DOWN = 274
    RIGHT = 275
    LEFT = 276
  end

  struct KeySym
    scan_code : UInt8
    sym : UInt32
    mod : UInt16
    unused : UInt32
  end

  struct KeyboardEvent
    type : UInt8
    which : UInt8
    state : UInt8
    key_sym : KeySym
  end

  union Event
    type : UInt8
    key : KeyboardEvent
  end



  fun init = SDL_Init(flags : UInt32) : Int32
  fun get_error = SDL_GetError() : UInt8*
  fun quit = SDL_Quit() : Void
  fun set_video_mode = SDL_SetVideoMode(width : Int32, height : Int32, bpp : Int32, flags : UInt32) : Surface*
  fun delay = SDL_Delay(ms : UInt32) : Void
  fun poll_event = SDL_PollEvent(event : Event*) : Int32
  fun wait_event = SDL_WaitEvent(event : Event*) : Int32
  fun lock_surface = SDL_LockSurface(surface : Surface*) : Int32
  fun unlock_surface = SDL_UnlockSurface(surface : Surface*) : Void
  fun update_rect = SDL_UpdateRect(screen : Surface*, x : Int32, y : Int32, w : Int32, h : Int32) : Void
  fun show_cursor = SDL_ShowCursor(toggle : Int32) : Int32
  fun get_ticks = SDL_GetTicks : UInt32
  fun flip = SDL_Flip(screen : Surface*) : Int32

  #############
  # My Stuff! #
  #############

  fun fill_rect = SDL_FillRect(dst : Surface*, dstrect : Rect*, color : UInt32) : Int32

  fun blit_surface = SDL_UpperBlit(src : Surface*, srcrect : Rect*, dst : Surface*, dstrect : Rect*) : Int32

  fun create_rgb_surface = SDL_CreateRGBSurface(flags : UInt32, width : Int32, height : Int32, depth : Int32, rmask : UInt32, gmask : UInt32, bmask : UInt32, amask : UInt32) : Surface*

  fun map_rgb = SDL_MapRGB(fmt : PixelFormat*, r : UInt8, g : UInt8, b : UInt8) : UInt32

  fun version      = SDL_Linked_Version() : Version*
end

lib SDLMain("SDLMain")
end

ifdef darwin
  lib LibCocoa("`echo \"-framework Cocoa\"`")
  end
end

undef main

redefine_main("SDL_main") do |main|
  {{main}}
end

lib LibSDL_image("SDL_image")
  fun load = IMG_Load(file : UInt8*) : LibSDL::Surface*
end

require "main"
require "version"
require "rect"
require "image"
require "surface"
require "color"
require "event"

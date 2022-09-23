import std/math as math
import ncurses
import vmath

import ./rasterizer.nim

proc main() =
  let w = initscr()
  defer: endwin()
  raw()
  noecho();
  var x, y: cint
  getmaxyx(w, y, x)

  let rasterizer = Rasterizer(height: y, width: x)

  var angle: float32 = 0
  while angle < 360:
    let transformation = rotate(math.degToRad(angle), vec3(0, 0, 1))
    var v1 = transformation * vec4(10, 10, 1, 1)
    var v2 = vec4(20, 10, 1, 1)
    var v3 = vec4(15, 20, 1, 1)

    rasterizer.rasterizeTriangle(vec2(v1.x, v1.y), vec2(v2.x, v2.y), vec2(v3.x, v3.y))
    getch()
    clear()
    angle += 5

  getch()

when isMainModule:
  main()

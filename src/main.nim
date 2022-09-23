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

  let transformation = scale(vec3(4,2,1))
  var v1 = transformation * vec4(10, 10, 1, 1)
  var v2 = vec4(20, 10, 1, 1)
  var v3 = vec4(15, 20, 1, 1)

  let rasterizer = Rasterizer(height: y, width: x)
  rasterizer.rasterizeTriangle(vec2(v1.x, v1.y), vec2(v2.x, v2.y), vec2(v3.x, v3.y))

  getch()

when isMainModule:
  main()

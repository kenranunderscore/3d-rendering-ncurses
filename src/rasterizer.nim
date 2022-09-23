import ncurses
import vmath

type
  Rasterizer* = ref object
    height*, width*: int

func isPointInTriangle(ptx, pty: float32, v1, v2, v3: Vec2): bool =
  let wv1 = ((v2.y - v3.y) * (ptx - v3.x) + (v3.x - v2.x) * (pty - v3.y)) /
        ((v2.y - v3.y) * (v1.x - v3.x) + (v3.x - v2.x) * (v1.y - v3.y))
  let wv2 = ((v3.y - v1.y) * (ptx - v3.x) + (v1.x - v3.x) * (pty - v3.y)) /
        ((v2.y - v3.y) * (v1.x - v3.x) + (v3.x - v2.x) * (v1.y - v3.y));
  let wv3 = 1 - wv1 - wv2

  let one = wv1 < -0.001
  let two = wv2 < -0.001
  let three = wv3 < -0.001

  return (one == two) and (two == three)

proc rasterizeTriangle*(rast: Rasterizer, v1, v2, v3: Vec2) =
  let minx = int(max(0, min(v1.x, min(v2.x, v3.x))))
  let miny = int(max(0, min(v1.y, min(v2.y, v3.y))))
  let maxx = int(min(float32 rast.width, max(v1.x, max(v2.x, v3.x)) + 1))
  let maxy = int(min(float32 rast.height, max(v1.y, max(v2.y, v3.y)) + 1))

  for j in countup(miny, maxy):
    for i in countup(minx, maxx):
      if isPointInTriangle(float32 i, float32 j, v1, v2, v3):
        mvprintw(cint j, cint i, "#")
      else:
        mvprintw(cint j, cint i, ".")

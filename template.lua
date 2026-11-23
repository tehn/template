-- template
-- @author
-- @url

tab = require 'tabutil'
engine.name = 'PolyPerc'

function init()
  print("init")
  engine.amp(0.5)
  engine.hz(200)
  -- clock
  clock.run(tick)
  -- grid
  g.init()
  -- arc
  a.init()
end


-- INTERFACE
-- ------------------------------

function key(n,z)
  print("key",n,z)
end

function enc(n,d)
  print("enc",n,d)
end

function redraw()
  screen.clear()
  screen.move(10,50)
  screen.text("time: "..t)
  screen.update()
end


-- CLOCK
-- ------------------------------
-- ------------------------------

t = 0
function tick()
  while true do
    t = t + 1
    redraw()
    clock.sleep(1)
  end
end


-- MIDI
-- ------------------------------
-- ------------------------------

m = midi.connect()

m.event = function(data)
  local d = midi.to_msg(data)
  print("midi in")
  tab.print(d)
end

-- m:note_on(60,127)
-- m:cc(60,127,1)


-- GRID
-- ------------------------------
-- ------------------------------
gr = grid.connect()

g = {
  dirty = true,
  update = function()
    while true do
      if g.dirty then
        g.dirty = false
        grid_redraw()
      end
      clock.sleep(1/60)
    end
  end,
  init = function() clock.run(g.update) end
}

function grid.add() g.dirty = true end

function grid_redraw()
  gr:all(0)
  gr:led(1,1,15)
  gr:refresh()
end

function gr.key(x,y,z)
  print("grid key",x,y,z)
  g.dirty = true
end


-- ARC
-- ------------------------------
-- ------------------------------
ar = arc.connect()

a = {
  dirty = true,
  update = function()
    while true do
      if a.dirty then
        a.dirty = false
        arc_redraw()
      end
      clock.sleep(1/60)
    end
  end,
  init = function() clock.run(a.update) end
}

function arc.add() a.dirty = true end

function arc_redraw()
  ar:all(0)
  ar:led(1,1,15)
  ar:refresh()
end

function ar.enc(n,d)
  print("arc enc",n,d)
  a.dirty = true
end

function ar.key(n,z)
  print("arc key",n,z)
  a.dirty = true
end

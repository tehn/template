-- template

function init()
	print("init")
	g.dirty = true
	g.init()
end


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

-- GRID REDRAW
-- ------------------------------
function grid_redraw()
  gr:all(0)
	gr:led(1,1,15)
	gr:refresh()
end

-- GRID KEY
-- ------------------------------
function gr.key(x,y,z)
	print("grid key",x,y,z)

	g.dirty = true
end


function key(n,z)
	print("key",n,z)
end

function enc(n,d)
	print("enc",n,d)
end

function redraw()
	screen.clear()
	screen.move(20,20)
	screen.text("template")
	screen.update()
end


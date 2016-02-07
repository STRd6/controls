TouchCanvas = require "touch-canvas"
Matrix = require "matrix"
Point = require "point"

TAU = 2 * Math.PI

width = 100
height = 100

value = 0.5 # [0..1]

canvas = TouchCanvas
  width: width
  height: height


document.body.appendChild canvas.element()

start = null
initial = null
canvas.on "touch", (p) ->
  initial = value
  start = Point(p)

canvas.on "move", (p) ->
  delta = Point(p).subtract(start)

  value = initial + 2 * (delta.x - delta.y)

  value = Math.min(Math.max(value, 0), 1)

canvas.on "release", ->

draw = ->
  canvas.fill('black')
  ratio = value

  x = width/2
  y = height/2
  radius = (width - 10) / 2

  context = canvas.context()
  context.lineWidth = 4

  canvas.withTransform Matrix.rotation(TAU/4, {x: x, y: y}), ->
    context.beginPath()
    context.arc(x, y, radius, 0, TAU * ratio)
    context.strokeStyle = "#FFF"
    context.stroke()

    context.beginPath()
    context.arc(x, y, radius, TAU * ratio, TAU)
    context.strokeStyle = "#888"
    context.stroke()

step = ->
  draw()

setInterval step, 1000/60

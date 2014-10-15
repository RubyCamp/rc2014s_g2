# -*- coding: shift_jis -*-
require 'dxruby'

require_relative 'scene'
require_relative 'scenes/load_scenes'

Window.caption = "激闘！　宍道湖七珍　生き残りを賭けた戦い！"
Window.width   = 800
Window.height  = 600
Window.fps =30
Scene.set_current_scene(:title)

Window.loop do
  break if Input.keyPush?(K_ESCAPE)

  Scene.play_scene
end

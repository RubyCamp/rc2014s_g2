# -*- coding: shift_jis -*-
require 'dxruby'

require_relative 'scene'
require_relative 'scenes/load_scenes'

Window.caption = "�����I�@�����Ύ����@�����c���q�����킢�I"
Window.width   = 800
Window.height  = 600
Window.fps =30
Scene.set_current_scene(:title)

Window.loop do
  break if Input.keyPush?(K_ESCAPE)

  Scene.play_scene
end

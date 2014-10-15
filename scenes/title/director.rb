module Title
  class Director
    def initialize
      @bg_img = Image.load("images/title.png")
      $bgm=Sound.new("sound/title.wav")
      $bgm.play
    end

    def play
      Window.draw(0, 0, @bg_img)
      if Input.keyPush?(K_SPACE)
        $bgm.stop
        $bgm.dispose
        Scene.set_current_scene(:game)
      end
    end
  end
end

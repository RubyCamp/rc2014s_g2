require_relative 'charactor'

module Scene1
  class Director
    def initialize
      $player1 = Charactor.new(100,200,1,$p1char)
      $player2 = Charactor.new(400,200,2,$p2char)
      @chars = [$player1,$player2]
      @bg_img = Image.load("images/battle.png")
      @hp_img = Image.load("images/hp.png")
      @hp_img.set_color_key([255,255,255])
      @power_img = Image.load("images/power.png")
      @power_img.set_color_key([255,255,255])
    end

    def gauge_draw
        #ゲージ類更新処理
      #Window.drawFont( 20, 20, $player1.hp.to_s,Font.new(40) )
      hp=(200*$player1.hp)/$player1.max_hp
      if hp<0
        hp=0
      end
      Window.drawBoxFill(100,25,hp+100,75,C_BLUE,z=1)  #1P体力ゲージの残り
      Window.drawBoxFill(100,25,300,75,C_RED,z=0)
    
    
     # Window.drawFont( 20, 100, $player1.play_num.to_s,Font.new(40) )
      @gauge_image = Window.drawBoxFill(100,100,(200*$player1.gauge_leng)/$player1.gauge_max+100,150,C_BLUE,z=1)  #1Pガードゲージの残り
      Window.drawBoxFill(100,100,300,150,C_RED,z=0)
    

      #Window.drawFont( 720, 20, $player2.hp.to_s,Font.new(40) )
      hp=(200*$player2.hp)/$player2.max_hp
      if hp<0
        hp=0
      end
      Window.drawBoxFill(500,25,hp+500,75,C_BLUE,z=1)  #2P体力ゲージの残り
      Window.drawBoxFill(500,25,700,75,C_RED,z=0)
    
    
      #Window.drawFont( 720, 100, $player2.play_num.to_s,Font.new(40) )
      @gauge_image = Window.drawBoxFill(500,100,(200*$player2.gauge_leng)/$player2.gauge_max+500,150,C_BLUE,z=1)  #2Pガードゲージの残り
      Window.drawBoxFill(500,100,700,150,C_RED,z=0)
      
      Window.draw(360,30,@hp_img)
      Window.draw(330,100,@power_img)

    end

    def play
      $player1.update($player2,K_SPACE)
      $player2.update($player1,K_RETURN)
      Window.draw(0,0,@bg_img)
      gauge_draw
      Sprite.draw(@chars)
    end
  end
end

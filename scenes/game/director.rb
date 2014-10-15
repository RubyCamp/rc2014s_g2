module Game
  class Director
  def initialize
    @bg_img = Image.load("images/select.png")
    @char_img1 = Image.load("images/player1_0sub.png")
    @char_img2 = Image.load("images/player1_1sub.png")
    @char_img3 = Image.load("images/player1_2sub.png")
    @char_img4 = Image.load("images/player1_3sub.png")
    @next_img  = Image.load("images/next_img.png")
    #@next_img.set_color_key([255,255,255])
    @player1_img = Image.load("images/1P.png")
    @player1_img.set_color_key([255,255,255])
    @player2_img = Image.load("images/2P.png")
    @player2_img.set_color_key([255,255,255])
    @select = 0  #プレイヤーが選択中のキャラ
    @player_select = 0  #どちらのプレイヤーが選択中か
    
  end
  
  def play
    Window.draw(0, 0, @bg_img)
    Window.draw(0, 0, @char_img1)
    Window.draw(200, 0, @char_img2)
    Window.draw(400, 0, @char_img3)
    Window.draw(600, 0, @char_img4)
    if @player_select == 0  #プレイヤーがどのキャラを選択しているか
      case @select
        when 0
          Window.draw(0, 0, @player1_img)
        when 1
          Window.draw(200, 0, @player1_img)
        when 2
          Window.draw(400, 0, @player1_img)
        when 3
          Window.draw(600, 0, @player1_img)
      end
    elsif @player_select ==1
      case @select
        when 0
          Window.draw(0, 0, @player2_img)
        when 1
          Window.draw(200, 0, @player2_img)
        when 2
          Window.draw(400, 0, @player2_img)
        when 3
          Window.draw(600, 0, @player2_img)
      end
    else
      Window.draw(200,400,@next_img)
    end
    
    @select += 1 if Input.keyPush?(K_RIGHT) && @select < 3
    @select -= 1 if Input.keyPush?(K_LEFT) && @select > 0
    
    #↓キャラのグローバル変数に入れる
    if Input.keyPush?(K_RETURN) 
      if @player_select == 0
        @player_select += 1
        $p1char = @select
        @select = 0
      elsif @player_select ==1
        @player_select += 1
        $p2char = @select
        @select = 0
      end
    end
    
    if @player_select >= 2 
      if Input.keyPush?(K_SPACE)
        $bgm=Sound.new("sound/battle_BGM#{rand(4)}.mid")
        $bgm.loopCount=-1
        $bgm.set_volume(200)
        $bgm.play
        Scene.add_scene(Scene1::Director.new,  :scene1)
        Scene.set_current_scene(:scene1)    #←シーン切り替え
      elsif Input.keyPush?(K_BACKSPACE)
        @player_select =0
      end
    end
    end
  end
end

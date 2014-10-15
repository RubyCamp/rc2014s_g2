class Charactor < Sprite
  def initialize(x, y,num,char,image = nil)
    @play_num = num
    @char=char
    image = Image.load("images/player#{@play_num}_0_0.png")
    @gauge_speed  #ゲージの早さ
    @gauge_leng   #今のゲージの長さ
    @gauge_max    #ゲージの最大値
    @gauge_image  #ゲージの画像
    @hp           #HP
    @max_hp       #最大HP
    @hp_image     #HPゲージの画像
    @attack_freq  #攻撃頻度（0.0~1.0）
    @guard_flag   #ガードのフラグ。1がガードしているときで0がガードしていないとき。
    @play_num     #プレイヤー番号。 1 or 2
    @effect_img = Image.load("images/attack1.png")
    @at_count =0

#debug用ここから
    @gauge_max = 200
    @gauge_leng = @gauge_max
    #@gauge_image  #ゲージの画像
    @guard_flag =0  #ガードのフラグ。1がガードしているときで0がガードしていないとき。
    
    
    
    @gauge_speed = 2
    @attack_freq =0.01 #攻撃頻度（0.0~1.0）
    @max_hp = 600
    
    
    if @char==0  #ワカサギ バランス型
      @gauge_speed = 2
      @attack_freq =0.01
      @max_hp = 600
    elsif @char == 1  #モロゲエビ ゲージが早い
      @gauge_speed = 4
      @attack_freq =0.007
      @max_hp = 400
    elsif @char == 2  #シジミ 防御型
      @gauge_speed = 2
      @attack_freq =0.005
      @max_hp = 1000
    elsif @char == 3  #スズキ パワー型
      @gauge_speed = 1
      @attack_freq =0.013
      @max_hp = 700
    end
    
    @hp=@max_hp
    
    @hit   = Sound.new("sound/hit.wav")
    @guard = Sound.new("sound/guard.wav")
    @hit.set_volume(255)
    @guard.set_volume(255)
#debug用ここまで
    super
  end

    attr_accessor :max_hp,:hp,:gauge_leng,:gauge_max,:guard_flag
    #↑外部から変数を書き換えるための設定

  def attack(enemy)
    if enemy.guard_flag == 0  #相手がガードしていないか
      enemy.hp -= @gauge_leng
      @gauge_leng/=2
      @hit.play
    else
      @gauge_leng*=0.75
      @guard.play
    end
    @at_count=6

  end
  
  def update(enemy,key)
    if Input.keyPush?(K_P)
      Window.getScreenShot("images/screen.jpg")
    end

    if @hp<=0 ||enemy.hp<=0  #勝敗判定
      img=Image.load("images/background_ending.png")
      img.set_color_key([255,255,255])
      Window.draw(0,0,img,5)
      if Input.keyPush?(K_N)
        Scene.delete_scene(:scene1,:game)
      end
      return
    end
  
    if  Input.keyDown?(key) && @gauge_leng>0 
      @gauge_leng -= 2
      @guard_flag =1
    else 
      @guard_flag=0
      @gauge_leng += @gauge_speed if @gauge_leng < @gauge_max
      if (rand < @attack_freq)&& (@gauge_leng>1) #攻撃が出るか否か？
        attack (enemy)
      end
    end


    #イメージの更新処理
    if @guard_flag == 0
      self.image=Image.load("images/player#{@play_num}_#{@char}.png")  #通常立ち絵
    else
      self.image=Image.load("images/player#{@play_num}_#{@char}_0.png")  #ガード絵
    end
    
    

    if @at_count>0
      @at_count-=1
      if @play_num == 1
        Window.draw(400,200,@effect_img,1)
      elsif @play_num ==2
        Window.draw(100,200,@effect_img,1)
      end
    end
    

  end
end
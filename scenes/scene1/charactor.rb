class Charactor < Sprite
  def initialize(x, y,num,char,image = nil)
    @play_num = num
    @char=char
    image = Image.load("images/player#{@play_num}_0_0.png")
    @gauge_speed  #�Q�[�W�̑���
    @gauge_leng   #���̃Q�[�W�̒���
    @gauge_max    #�Q�[�W�̍ő�l
    @gauge_image  #�Q�[�W�̉摜
    @hp           #HP
    @max_hp       #�ő�HP
    @hp_image     #HP�Q�[�W�̉摜
    @attack_freq  #�U���p�x�i0.0~1.0�j
    @guard_flag   #�K�[�h�̃t���O�B1���K�[�h���Ă���Ƃ���0���K�[�h���Ă��Ȃ��Ƃ��B
    @play_num     #�v���C���[�ԍ��B 1 or 2
    @effect_img = Image.load("images/attack1.png")
    @at_count =0

#debug�p��������
    @gauge_max = 200
    @gauge_leng = @gauge_max
    #@gauge_image  #�Q�[�W�̉摜
    @guard_flag =0  #�K�[�h�̃t���O�B1���K�[�h���Ă���Ƃ���0���K�[�h���Ă��Ȃ��Ƃ��B
    
    
    
    @gauge_speed = 2
    @attack_freq =0.01 #�U���p�x�i0.0~1.0�j
    @max_hp = 600
    
    
    if @char==0  #���J�T�M �o�����X�^
      @gauge_speed = 2
      @attack_freq =0.01
      @max_hp = 600
    elsif @char == 1  #�����Q�G�r �Q�[�W������
      @gauge_speed = 4
      @attack_freq =0.007
      @max_hp = 400
    elsif @char == 2  #�V�W�~ �h��^
      @gauge_speed = 2
      @attack_freq =0.005
      @max_hp = 1000
    elsif @char == 3  #�X�Y�L �p���[�^
      @gauge_speed = 1
      @attack_freq =0.013
      @max_hp = 700
    end
    
    @hp=@max_hp
    
    @hit   = Sound.new("sound/hit.wav")
    @guard = Sound.new("sound/guard.wav")
    @hit.set_volume(255)
    @guard.set_volume(255)
#debug�p�����܂�
    super
  end

    attr_accessor :max_hp,:hp,:gauge_leng,:gauge_max,:guard_flag
    #���O������ϐ������������邽�߂̐ݒ�

  def attack(enemy)
    if enemy.guard_flag == 0  #���肪�K�[�h���Ă��Ȃ���
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

    if @hp<=0 ||enemy.hp<=0  #���s����
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
      if (rand < @attack_freq)&& (@gauge_leng>1) #�U�����o�邩�ۂ��H
        attack (enemy)
      end
    end


    #�C���[�W�̍X�V����
    if @guard_flag == 0
      self.image=Image.load("images/player#{@play_num}_#{@char}.png")  #�ʏ헧���G
    else
      self.image=Image.load("images/player#{@play_num}_#{@char}_0.png")  #�K�[�h�G
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
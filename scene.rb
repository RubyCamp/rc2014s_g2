class Scene
  @@scenes = {}

  @@current_scene_name = nil

  def self.add_scene(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  def self.set_current_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
  end


  def self.play_scene
    @@scenes[@@current_scene_name].play
  end


  def self.delete_scene(delete_scene,next_scene)
    @@scenes.delete delete_scene.to_sym
    self.set_current_scene(next_scene)
  end

end
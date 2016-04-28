require 'yaml'

class Configuration
  CONFIG_FILE = 'config.yml'

	attr_accessor :use_mouse, :show_fps, :server_ip, :server_port, :nickname

	def initialize
    read
	end

  def to_yaml
    config = Hash.new

    config['player'] = Hash.new
    config['player']['nickname'] = @nickname
    config['input'] = Hash.new
    config['input']['use_mouse'] = @use_mouse
    config['video'] = Hash.new
    config['video']['show_fps'] = @show_fps
    config['multiplayer'] = Hash.new
    config['multiplayer']['server_ip'] = @server_ip
    config['multiplayer']['server_port'] = @server_port

    return config.to_yaml
  end

  def from_yaml(config)
    @nickname = config['player']['nickname']
    @use_mouse = config['input']['use_mouse']
    @show_fps = config['video']['show_fps']
    @server_ip = config['multiplayer']['server_ip']
    @server_port = config['multiplayer']['server_port']
  end

  def write
    config = to_yaml
    File.open(CONFIG_FILE,'w') do |c| 
       c.write config
    end
  end

  def read
    def_config = default_config
    config = YAML.load_file(CONFIG_FILE)
    final_config = def_config.merge(config)
    from_yaml(final_config)
  end

  def default_config
    config = Hash.new
    config['player'] = Hash.new
    config['player']['nickname'] = "Guest" + rand(0..1000).to_s
    config['input'] = Hash.new
    config['input']['use_mouse'] = true
    config['video'] = Hash.new
    config['video']['show_fps'] = false
    config['multiplayer'] = Hash.new
    config['multiplayer']['server_ip'] = "127.0.0.1"
    config['multiplayer']['server_port'] = 9956
    return config
  end
end
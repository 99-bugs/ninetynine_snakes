require 'yaml'

class ConfigFileMissing < Exception; end

class Configuration
  CONFIG_FILE = 'config.yml'

	attr_accessor :server_ip,
                :server_port,
                :nickname

	def initialize
    @nickname = "Player_" + rand(0..1000).to_s
    @use_mouse = true
    @show_fps = false
    @server_ip = "127.0.0.1"
    @server_port = 9956

    begin
      read_from_config_file
    rescue ConfigFileMissing
      write_to_config_file
    end
	end

  def read_from_config_file
    raise ConfigFileMissing.new unless File.exists?(CONFIG_FILE)
    from_yaml(YAML.load_file(CONFIG_FILE))
  end

  def write_to_config_file
    File.open(CONFIG_FILE,'w') do |c| 
       c.write to_yaml
    end
  end

  def use_mouse?
    @use_mouse
  end

  def show_fps?
    @show_fps
  end

  private
  def to_hash
    config = Hash.new

    config['player'] = Hash.new
    create_option(config['player'], 'nickname', "Enter your NickName:", :text, @nickname)

    config['input'] = Hash.new
    create_option(config['input'], 'use_mouse', "Use mouse for steering? ", :bool, @use_mouse)

    config['video'] = Hash.new
    create_option(config['video'], 'show_fps', "Show FPS?", :bool, @show_fps)

    config['multiplayer'] = Hash.new
    create_option(config['multiplayer'], 'server_ip', "IPv4 Address of Server:", :ip_address, @server_ip)
    create_option(config['multiplayer'], 'server_port', "Port of Server:", :integer, @server_port)

    return config
  end

  def to_yaml
    # Remove all unneeded info such as label and type
    config = to_hash.clone
    config.each do |k, category|
      category.each do |l, option|
        config[k][l] = option['value']
      end
    end
    config.to_yaml
  end

  def from_yaml(config)
    @nickname = config['player']['nickname']
    @use_mouse = config['input']['use_mouse']
    @show_fps = config['video']['show_fps']
    @server_ip = config['multiplayer']['server_ip']
    @server_port = config['multiplayer']['server_port']
  end

  def create_option(config, key, label, type, default_value)
    config[key] = Hash.new
    config[key]['label'] = label
    config[key]['value'] = default_value
    config[key]['type'] = type
  end
end
require 'yaml'

class Configuration
  CONFIG_FILE = 'config.yml'

	attr_accessor :use_mouse, :show_fps, :server_ip, :server_port, :nickname

	def initialize
    # Default config
    @nickname = "Player_" + rand(0..1000).to_s
    @use_mouse = true
    @show_fps = false
    @server_ip = "127.0.0.1"
    @server_port = 9956

    read
	end

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
    # We need to remove all unneeded info
    yamlconfig = to_hash.clone
    yamlconfig.each do |k, category|
      category.each do |l, option|
        yamlconfig[k][l] = option['value']
      end
    end
    yamlconfig.to_yaml
  end

  def from_yaml(yamlconfig)
    # We need to create similar structure to our config
    yamlconfig.each do |k, category|
      category.each do |l, option|
        yamlconfig[k][l] = Hash.new
        yamlconfig[k][l]['value'] = option
      end
    end
    yamlconfig
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
    # We need to create similar structure to our config
    yamlconfig = YAML.load_file(CONFIG_FILE)
    from_yaml(yamlconfig)
  end

  def create_option(config, key, label, type, default_value)
    config[key] = Hash.new
    config[key]['label'] = label
    config[key]['value'] = default_value
    config[key]['type'] = type
  end
end
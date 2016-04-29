class OptionsScreenFactory

  # sub_key is key for options in config hash
  def self.build_options_screen(window, font, configuration, key, callback)
    config_options = configuration.to_hash[key]

    screen = InputScreen.new(window, callback)
    config_options.each do |k,v|
      screen.add_input(font, v['label'], k, v['type'], v['value'])
    end

    return screen
  end

  # sub_key is key for options in config hash
  def self.build_multiplayer_start_screen(window, font, configuration, callback)
    config_options = configuration.to_hash
    ip_address = config_options['multiplayer']['server_ip']
    nickname = config_options['player']['nickname']

    screen = InputScreen.new(window, callback)
    screen.add_input(font, ip_address['label'], 'server_ip', ip_address['type'], ip_address['value'])
    screen.add_input(font, nickname['label'], 'nickname', nickname['type'], nickname['value'])

    return screen
  end

end
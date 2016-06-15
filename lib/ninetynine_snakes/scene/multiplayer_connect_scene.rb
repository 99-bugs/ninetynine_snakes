class MultiplayerConnectScene < InputScene

  def initialize universe, camera, input_manager
    super(universe, camera, input_manager)

    @text_object = Gosu::Font.new(@game_window, 'Ubuntu Sans', 24)

    config_options = @game_window.configuration.to_hash
    ip_address = config_options['multiplayer']['server_ip']
    nickname = config_options['player']['nickname']

    add_input(@text_object, ip_address['label'], 'server_ip', ip_address['type'], ip_address['value'])
    add_input(@text_object, nickname['label'], 'nickname', nickname['type'], nickname['value'])

    @callback = method(:multiplayer_connect_callback)
  end

  private
  def multiplayer_connect_callback
    if (all_validates?)
      server_ip = get_input('server_ip').text
      nickname = get_input('nickname').text

      @game_window.start_multiplayer nickname, server_ip
    else
      validate_all!
    end
  end
end
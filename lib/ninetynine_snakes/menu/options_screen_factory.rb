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
end
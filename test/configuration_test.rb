require 'test_helper'

describe Configuration, "Player configuration" do

  before do
    @configuration = Configuration.new
    @configuration.reset!
  end

  it "should have a reset" do
    @configuration.must_respond_to :reset!
  end

  describe ".reset" do

    it "should set values to default" do
      @configuration.use_mouse?.must_equal true
      @configuration.show_fps?.must_equal false
      @configuration.server_ip.must_equal "127.0.0.1"
      @configuration.server_port.must_equal 9956
      @configuration.nickname.must_contain "Player_"
      @configuration.snake_head_texture.must_equal "snake.png"
      @configuration.snake_body_texture.must_equal "snake.png"
    end

  end

end
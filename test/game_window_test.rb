require 'test_helper'

describe GameWindow, "Gosu Game Window" do

  before do
    @game = GameWindow.new
  end

  describe "a new window" do
    it "should be a GameWindow and a Gosu::Window" do
      @game.must_be_instance_of GameWindow
      @game.must_be_kind_of Gosu::Window
    end

    it "should have a default width" do
      @game.width.must_equal 800
    end

    it "should have a default height" do
      @game.height.must_equal 450
    end

    it "should have a caption" do
      @game.caption.must_equal "99-Snakes"
    end
  end

  describe "main menu" do

    it "should close when escape is hit" do
      # 1) Create mock
      game_mock = Minitest::Mock.new
      game_mock.expect :close, nil, []

      # 2) Place mock
      @game.instance_exec(game_mock) do |mock|
        @mock = mock
        def close
          @mock.close
        end
      end

      # 3) Verify mock was called
      escape_key = Gosu::KbEscape
      @game.button_down(escape_key)
      game_mock.verify
    end

  end

end
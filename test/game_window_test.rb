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

    it "should have an input manager" do
      @game.must_respond_to :input_manager
    end

    it "should show the main menu" do
      @game.instance_variable_get(:@scene).must_be_instance_of MainMenuScene
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

    it "should close when exit is clicked" do
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
      menu_scene = @game.instance_variable_get(:@scene)
      menu = menu_scene.instance_variable_get(:@menu)
      exit_item_boundaries = menu.instance_variable_get(:@entries).last.boundaries
      click_location = Point.new(exit_item_boundaries[:top_left].x + 1, exit_item_boundaries[:top_left].y + 1)
      menu.clicked(click_location)
      game_mock.verify
    end

  end

end
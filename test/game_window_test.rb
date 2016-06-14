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

end
require 'test_helper'

describe GameWindow, "Gosu Game Window" do

  before do
    @game = GameWindow.new
  end

  it "should be a GameWindow and a Gosu::Window" do
    @game.must_be_instance_of GameWindow
    @game.must_be_kind_of Gosu::Window
  end
end
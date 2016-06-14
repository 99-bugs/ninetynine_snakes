require 'test_helper'

describe InputManager, "Manages all user input" do

  let(:escape_key) { Gosu::KbEscape }
  let(:left_key) { Gosu::KbLeft }

  before do
    @input_manager = InputManager.new
  end

  describe ".new" do
    it "should create new instance of InputManager" do
      @input_manager.must_be_instance_of InputManager
    end
  end

  describe ".button_down" do
    it "should have a method button_down" do
      @input_manager.must_respond_to :button_down
    end
  end

  describe "hooking to events" do

    before do
      @result = nil

      @input_manager.on_key_down :escape_key do |event|
        @result = event
      end

      @input_manager.on_key_up :escape_key do |event|
        @result = event
      end
    end

    it "should call block on key down" do
      @input_manager.button_down :escape_key

      @result[:state].must_equal :key_down
      @result[:key_id].must_equal :escape_key
    end

    it "should call block on key up" do
      @input_manager.button_up :escape_key

      @result[:state].must_equal :key_up
      @result[:key_id].must_equal :escape_key
    end

    it "should not call block for different key" do
      @input_manager.button_up :left_key

      @result.must_be_nil
    end
  end

end
# Based on: http://oflute.googlecode.com/svn/tutGosu/ejemplo/gosu/examples/TextInput.rb

class IpAddress < TextField
 
  def initialize(window, font, x, y)
    super(window, font, x, y)
  end

  def validates?
    ip = /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})$/.match(text)
    !ip.nil?
  end

  def validate!
    if (!validates?)
      self.text = "Invalid"
    end
  end
end
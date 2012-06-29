class PageMaker

  def initialize browser, visit = false
    @browser = browser
    goto if visit
    expected_element if respond_to? :expected_element
    has_expected_title? if respond_to? :has_expected_title?
  end

  # This hash contains all page classes and their associated
  # 'crucial elements', defined as: those elements deemed necessary
  # before the build is in a testable state. Classes and elements
  # are added here by invoking the crucial_element method in a
  # class.
  @@crucial_elements = {}

  def method_missing sym, *args, &block
    @browser.send sym, *args, &block
  end

  class << self

    def page_url url
      define_method 'goto' do
        @browser.goto url
      end
    end

    def expected_element type, identifier, timeout=30
      define_method 'expected_element' do
        @browser.send("#{type.to_s}", identifier).wait_until_present timeout
      end
    end

    def expected_title expected_title
      define_method 'has_expected_title?' do
        has_expected_title = expected_title.kind_of?(Regexp) ? expected_title =~ @browser.title : expected_title == @browser.title
        raise "Expected title '#{expected_title}' instead of '#{@browser.title}'" unless has_expected_title
      end
    end

    def element element_name
      raise "#{element_name} is being defined twice in #{self}!" if self.instance_methods.include?(element_name.to_sym)
      define_method element_name.to_s do
        yield self
      end
    end

    def crucial_element element_name
      @@crucial_elements[self] == nil ? @@crucial_elements.store(self, []) :#Do nothing
      @@crucial_elements[self] << element_name
      # TODO: Figure out why the next four lines can't be reduced to a call to the above 'element' method.
      raise "#{element_name} is being defined twice in #{self}!" if self.instance_methods.include?(element_name.to_sym)
      define_method element_name.to_s do
        yield self
      end
    end

    alias :value :element
    alias :action :element

  end

  def crucial_elements_exist?
    x = true
    @@crucial_elements[self.class].each do |page_item|
      unless self.send(page_item).exists?
        puts "Can't find #{page_item.to_s} element on the page!"
        x = false
      end
    end
    return x
  end

end
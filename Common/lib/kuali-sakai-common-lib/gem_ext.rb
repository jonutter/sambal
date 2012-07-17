# Methods to extend the page-object gem...
module PageObject
  module Elements
    class Element
      def disabled?
        @element.disabled?
      end
    end
  end
  module Accessors
    def thing element_name
      define_method element_name.to_s do
        yield self
      end
    end
    alias item thing
    alias value thing
    alias action thing
  end
end

# Need this to extend Watir to be able to attach to Sakai's non-standard tags...
module Watir
  class Element
    # attaches to the "headers" tags inside of the assignments table.
    def headers
      @how = :ole_object
      return @o.headers
    end

    # attaches to the "for" tags in "label" tags.
    def for
      @how = :ole_object
      return @o.for
    end

    # attaches to the "summary" tag
    def summary
      @how = :ole_object
      return @o.summary
    end

  end
end
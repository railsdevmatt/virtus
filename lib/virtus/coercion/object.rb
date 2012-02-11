module Virtus
  class Coercion

    # Coerce Object values
    class Object < Coercion
      primitive ::Object

      COERCION_METHOD_REGEXP = /\Ato_/.freeze

      # Create an Array from any Object
      #
      # @example with an object that does not respond to #to_a or #to_ary
      #   Virtus::Coercion::Object.to_array(value)         # => [ value ]
      #
      # @example with an object that responds to #to_a
      #   Virtus::Coercion::Object.to_array(Set[ value ])  # => [ value ]
      #
      # @example with n object that responds to #to_ary
      #   Virtus::Coercion::Object.to_array([ value ])     # => [ value ]
      #
      # @param [#to_a,#to_ary,Object] value
      # @param [#to_a,#to_ary,Object] value
      #
      # @return [Array]
      #
      # @api public
      def self.to_array(value)
        Array(value)
      end

      # Create a Hash from the Object if possible
      #
      # @overload value is coercible into Hash
      #
      #   @example
      #     Virtus::Coercion::Object.to_hash(key => value)  # => { key => value }
      #
      #   @param [#to_hash] value
      #
      #   @return [Hash]
      #
      # @overload value is not coercible into Hash
      #
      #   @example
      #     Virtus::Coercion::Object.to_hash(value)  # => value
      #
      #   @param [Object] value
      #
      #   @return [Object]
      #
      # @api public
      def self.to_hash(value)
        value.respond_to?(:to_hash) ? value.to_hash : value
      end

      # Passthrough given value
      #
      # @param [Object] value
      #
      # @return [Object]
      #
      # @api private
      def self.method_missing(method, *args)
        if method.to_s =~ COERCION_METHOD_REGEXP && args.size == 1
          args.first
        else
          super
        end
      end

      private_class_method :method_missing

    end # class Object
  end # class Coercion
end # module Virtus

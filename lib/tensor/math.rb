module Tensor
  private_class_method def self.unary_function(*names)
    names.each do |name|
      self.module_eval <<~FUNC
        module_function

        def #{name}(x, out: nil)
          if x.respond_to?(:#{name})
            x.#{name}(out: out)
          elsif x.respond_to?(:tensor_method_missing)
            x.tensor_method_missing(:#{name}, out: out)
          else
            Tensor.no_method_error(:#{name}, x, out: out)
          end
        end
      FUNC
    end
  end

  private_class_method def self.binary_function(*names)
    names.each do |name|
      self.module_eval <<~FUNC
        module_function

        def #{name}(x1, x2)
          if x1.respond_to?(:#{name})
            x1.#{name}(x2)
          elsif x1.respond_to?(:tensor_method_missing)
            x1.tensor_method_missing(:#{name}, x2)
          else
            Tensor.no_method_error(:#{name}, x1, x2)
          end
        end
      FUNC
    end
  end

  unary_function :exp, :log, :log10, :log2
  unary_function :sin, :cos, :tan, :asin, :acos, :atan
  binary_function :atan2
end

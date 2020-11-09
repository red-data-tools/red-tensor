require "numo/narray"

# Here is a tentative implementation
class Numo::NArray
  def tensor_method_missing(method_name, *args, out: nil)
    out && check_type(out, Numo::NArray, :out)
    if self.class::Math.respond_to?(method_name)
      result = self.class::Math.__send__(method_name, self, *args)
      if out
        if result.shape == out.shape
          out[true] = result
          out
        else
          raise ArgumentError, "shape mismatched between result and out"
        end
      else
        result
      end
    else
      Tensor.no_method_error(method_name, *args)
    end
  end

  private

  def check_type(obj, type, name)
    return if obj.kind_of?(type)
    raise TypeError, "#{name} should be an instance of #{type}"
  end
end

class NarrayTest < Test::Unit::TestCase
  sub_test_case "math functions" do
    def test_exp
      x = Numo::DFloat[1, 2, 3, 4, 5]
      result = Tensor.exp(x)
      assert_equal({class: Numo::DFloat, result: Numo::NMath.exp(x)},
                   {class: result.class, result: result})
    end

    def test_exp_with_out
      x = Numo::DFloat[1, 2, 3, 4, 5]
      y = Numo::DFloat[0, 0, 0, 0, 0]
      result = Tensor.exp(x, out: y)
      assert { result.equal?(y) }
      assert_equal(Numo::NMath.exp(x), y)
    end

    def test_log
      x = Numo::DFloat[1, 2, 3, 4, 5]
      result = Tensor.log(x)
      assert_equal({class: Numo::DFloat, result: Numo::NMath.log(x)},
                   {class: result.class, result: result})
    end

    def test_log10
      x = Numo::DFloat[1, 2, 3, 4, 5]
      result = Tensor.log10(x)
      assert_equal({class: Numo::DFloat, result: Numo::NMath.log10(x)},
                   {class: result.class, result: result})
    end

    def test_log2
      x = Numo::DFloat[1, 2, 3, 4, 5]
      result = Tensor.log2(x)
      assert_equal({class: Numo::DFloat, result: Numo::NMath.log2(x)},
                   {class: result.class, result: result})
    end

    sub_test_case "trigonometory functions" do
      def setup
        @x = Numo::DFloat[0, 0.5, 1, 1.5, 2] * Math::PI
      end

      def test_sin
        result = Tensor.sin(@x)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.sin(@x)},
                     {class: result.class, result: result})
      end

      def test_cos
        result = Tensor.cos(@x)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.cos(@x)},
                     {class: result.class, result: result})
      end

      def test_tan
        result = Tensor.tan(@x)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.tan(@x)},
                     {class: result.class, result: result})
      end

      def test_asin
        y = Tensor.sin(@x)
        result = Tensor.asin(y)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.asin(y)},
                     {class: result.class, result: result})
      end

      def test_acos
        y = Tensor.cos(@x)
        result = Tensor.acos(y)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.acos(y)},
                     {class: result.class, result: result})
      end

      def test_atan
        y = Tensor.tan(@x)
        result = Tensor.atan(y)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.atan(y)},
                     {class: result.class, result: result})
      end

      def test_atan2
        t = Numo::DFloat.linspace(0, 360, 9).deg2rad
        x = Tensor.cos(t)
        y = Tensor.sin(t)
        result = Tensor.atan2(y, x)
        assert_equal({class: Numo::DFloat, result: Numo::NMath.atan2(y, x)},
                     {class: result.class, result: result})
      end
    end
  end
end

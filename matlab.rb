#matlab_helper.rb
$VERBOSE = nil # surpress constant redefinition warnings
include Math

def norm(vector)
  sqrt vector.map{ |x| x**2 }.inject(0, &:+)
end

class Array
  def +(op)
    self.zip(op).map { |a, b| a + b }
  end

  def -(op)
    self.zip(op).map { |a, b| a - b }
  end

  def *(op)
    self.zip(op).map { |a, b| a * b }
  end

  def /(op)
    self.map { |a| a / op }
  end
end

class Float
  alias_method :mult, :*
  alias_method :plus, :+

  def *(op)
    if op.is_a? Array
      op.map { |a| self * a }
    else
      mult op
    end
  end

  def +(op)
    if op.is_a? Array
      op.map { |a| self + a }
    else
      plus op
    end
  end
end

class Fixnum
  alias_method :mult, :*

  def *(op)
    if op.is_a? Array
      op.map { |a| self * a }
    else
      mult op
    end
  end
end

def pi
  PI
end

def sina(op)
  op.map { |a| sin(a) }
end

def cosa(op)
  op.map { |a| cos(a) }
end

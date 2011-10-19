module Anaphora
  class BlankSlate
    instance_methods.each {|m| undef_method(m) unless m =~ /^__/}
  end

  class MethodInvocation < Struct.new(:name, :args, :block)
    def send_to(target)
      target.send(name, *args, &block)
    end
  end

  class Proxy < BlankSlate

    def initialize
      @methods = []
    end

    def to_proc
      lambda {|it| @methods.inject(it) {|target, method| method.send_to(target) }}
    end

    def method_missing(name, *args, &block)
      return true if name == :respond_to? && args.first == :to_proc
      @methods << MethodInvocation.new(name, args, block)
      self
    end

  end
end

module Kernel
  def it
    Anaphora::Proxy.new
  end
  alias_method :its, :it
end
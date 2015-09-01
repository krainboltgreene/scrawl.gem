class Scrawl
  include Enumerable

  KEY_VALUE_DELIMITER = "="
  PAIR_DELIMITER = " "
  NAMESPACE_DELIMITER = "."

  require_relative "scrawl/version"

  attr_reader :tree

  def initialize(*trees)
    @tree = trees.inject({}) { |global, tree| global.merge(tree) }
  end

  def merge(hash)
    @tree.merge!(hash.to_hash)
  end

  def inspect(namespace = nil)
    @tree.map do |key, value|
      case
      when value.kind_of?(Hash) && value.none?
        label(namespace, key) + KEY_VALUE_DELIMITER + element(nil)
      when value.respond_to?(:to_hash)
        Scrawl.new(value).inspect(key)
      else
        label(namespace, key) + KEY_VALUE_DELIMITER + element(value)
      end
    end.join(PAIR_DELIMITER)
  end

  def to_s(namespace = nil)
    inspect(namespace)
  end

  def each(&block)
    tree.each(&block)
  end

  def to_hash
    tree.to_hash
  end

  def to_h
    tree.to_h
  end

  private def label(namespace, key)
    [namespace, key].compact.join(NAMESPACE_DELIMITER)
  end

  private def element(value)
    case value
      when Proc then element(value.call)
      when Symbol then element(value.to_s)
      else value.inspect
    end
  end
end

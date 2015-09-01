class Scrawl
  include Enumerable

  KEY_VALUE_DELIMITER = "="
  PAIR_DELIMITER = " "
  NAMESPACE_DELIMITER = "."
  DEFAULT_SPLAT_CHARACTER="*"

  def initialize(*trees)
    @tree = trees.inject({}) { |global, tree| global.merge(tree) }
  end

  def merge(hash)
    @tree.merge!(hash.to_hash)
  end

  def inspect(namespace = nil)
    tree.map do |key, value|
      case
        when value.nil? then nil
        when value.respond_to?(:none?) && value.none? then nil
        when value.respond_to?(:push) then itemize(namespace, key, value)
        when value.respond_to?(:merge) then Scrawl.new(value).inspect(key)
        else label(namespace, key) + KEY_VALUE_DELIMITER + element(value)
      end
    end.flatten.compact.join(PAIR_DELIMITER)
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

  private def tree
    @tree
  end

  private def itemize(namespace, key, list)
    list.map do |item|
      label(namespace, label(key, DEFAULT_SPLAT_CHARACTER)) + KEY_VALUE_DELIMITER + element(item)
    end
  end

  require_relative "scrawl/version"
end

# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def cast_to_node(expression)
      case expression
      when Arel::Nodes::Node, Arel::Attributes::Attribute
        expression
      when String
        Arel.sql(expression)
      else
        raise ArgumentError
      end
    end

    # Arel node for a DENSE_RANK window function, can be used in a `SELECT` clause.
    def is_top(*orders, top: 20)
      window = Arel::Nodes::Window.new
      window.orders += orders.map{ |o| cast_to_node(o) }
      Arel::Nodes::Over.new(Arel::Nodes::NamedFunction.new('DENSE_RANK', []), window).then do |wf|
        wf.lteq(top).as("top_#{top}")
      end
    end

    # Arel node for a MySQL function that returns 0 if the expression is NULL
    # Useful for e.g. doing math with a non-existant Quiz Score.
    def null_as_zero(expression)
      Arel::Nodes::NamedFunction.new('IFNULL', [cast_to_node(expression), 0])
    end
  end
end

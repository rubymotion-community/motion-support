require_relative 'module/delegation'

class NSString
  def to_s
    String.new(self)
  end
  
  delegate :at, :blank?, :camelcase, :camelize, :classify, :constantize, :dasherize,
           :deconstantize, :demodulize, :exclude?, :first, :foreign_key, :from, :humanize,
           :indent, :indent!, :last, :pluralize, :safe_constantize, :singularize,
           :squish, :squish!, :strip_heredoc, :tableize, :titlecase, :titleize, :to,
           :truncate, :underscore,
           :to => :to_s
end

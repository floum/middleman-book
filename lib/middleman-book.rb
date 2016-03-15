class Book < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end
end

::Middleman::Extensions.register(:book, Book)

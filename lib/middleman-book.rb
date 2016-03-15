require "middleman-core"

Middleman::Extensions.register :middleman-book do
  require "my-extension/extension"
  MyExtension
end

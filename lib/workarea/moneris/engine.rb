module Workarea
  module Moneris
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Moneris
    end
  end
end

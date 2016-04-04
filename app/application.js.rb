require 'inesita'
require 'browser'
require 'browser/audio'
require 'browser/storage'
require 'browser/interval'
require 'browser/canvas'
require 'browser/immediate'
require 'virtual_dom/external_support/browser'
require 'store'
require 'layout'

require_tree './components'

$document.ready do
  App = Inesita::Application.new(
    store: Store,
    layout: Layout
  ).mount_to($document['app'])
end

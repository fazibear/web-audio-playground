require 'inesita'

require 'browser'
require 'browser/audio'
require 'browser/storage'
require 'browser/interval'
require 'browser/canvas'
require 'browser/immediate'
require 'virtual_dom/support/browser'

require 'store'

require_tree './components'

class Application
  include Inesita::Component

  inject Store

  def render
    div id: 'screen' do
      component router
    end
  end

  def initialize
    @canvas = $document['canvas']
    @ctx = Browser::Canvas.new(@canvas)
  end

  def render
    component NavBar
    div hook: hook(:after_render) do
      store.state.each do |_id, node|
        component Kernel.const_get(node[:type].capitalize), props: node
      end
    end
  end

  def after_render(node)
    defer do
      @ctx.clear
      @ctx.begin
      store.connections.each do |c|
        src = $document[c.first]
        dst = $document[c.last]

        src_x = src.offset.x + src.width
        src_y = src.offset.y + (src.height / 2)
        dst_x = dst.offset.x
        dst_y = dst.offset.y + (src.height / 2)

        draw_line(src_x, src_y, dst_x, dst_y)
      end
    end
  end

  def draw_line(x,y,a,b)
    @ctx.move_to(x,y)
    @ctx.line_to(a,b)
    @ctx.stroke
  end
end

$document.ready do
  Application.mount_to($document['app'])
end

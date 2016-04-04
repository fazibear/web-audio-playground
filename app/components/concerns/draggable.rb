module Draggable
  def init_draggable
    $document.on('mouseup') do |e|
      e.prevent
      @drag = false
      render!
    end

    $document.on('mousemove') do |e|
      e.prevent
      if @drag
        props[:y] = e.page.y - @offset_y
        props[:x] = e.page.x - @offset_x
        render!
      end
    end
  end

  def start_drag(e)
    e.prevent
    @offset_x = e.offset.x
    @offset_y = e.offset.y
    @drag = true
    render!
  end
end

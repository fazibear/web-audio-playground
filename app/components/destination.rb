class Destination
  include Inesita::Component
  include Draggable

  def initialize
    init_draggable
  end

  def render
    div class: 'panel panel-danger node',
        style: { left: props[:x].to_s + 'px', top: props[:y].to_s + 'px' } do
      div class: 'panel-heading', onmousedown: method(:start_drag) do
        'Destination'
      end
      table class: 'table' do
        tbody do
          tr do
            td id: "input-#{props[:id]}" do
              '➤'
            end
            td do
            end
            td class: 'pull-right' do
              '⨂'
            end
          end
        end
      end
    end
  end
end

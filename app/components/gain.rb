class Gain
  include Inesita::Component
  include Draggable

  def initialize
    init_draggable
  end

  def change_gain(e)
    store.set_node_parameter(props[:id], :gain, e.target.value.to_i)
  end

  def render
    div class: 'panel panel-warning node',
        style: { left: props[:x].to_s + 'px', top: props[:y].to_s + 'px' } do
      div class: 'panel-heading', onmousedown: method(:start_drag) do
        'Gain'
      end
      table class: 'table' do
        tbody do
          tr  do
            td id: "input-#{props[:id]}" do
              '➤'
            end
            td do
            end
            td id: "output-#{props[:id]}", class: 'pull-right' do
              '➤'
            end
          end

          tr do
            td { '➤' }
            td do
              'Gain'
            end
            td do
              input type: 'text', class: 'form-control input-sm pull-right', value: store.get_node_parameter(props[:id], :gain), onchange: method(:change_gain)
            end
          end
        end
      end
    end
  end
end

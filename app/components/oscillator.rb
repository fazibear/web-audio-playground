class Oscillator
  include Inesita::Component
  include Draggable

  def initialize
    init_draggable
  end

  def start
    store.invoke_node_action(props[:id], :start)
  end

  def stop
    store.invoke_node_action(props[:id], :stop)
  end

  def change_frequency(e)
    store.set_node_parameter(props[:id], :frequency, e.target.value.to_f)
  end

  def change_detune(e)
    store.set_node_parameter(props[:id], :detune, e.target.value.to_f)
  end

  def change_type(e)
    store.set_node_parameter(props[:id], :type, e.target.value)
  end

  def render
    div class: 'panel panel-primary node',
        style: { left: props[:x].to_s + 'px', top: props[:y].to_s + 'px' } do
      div class: 'panel-heading', onmousedown: method(:start_drag) do
        'Oscillator'
      end
      table class: 'table' do
        tbody do
          tr do
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
            td id: "input-#{props[:id]}-type" do
              '➤'
            end
            td do
              'Type'
            end
            td do
              select class: 'form-control input-sm pull-right', onchange: method(:change_type) do
                Browser::Audio::Node::Oscillator::TYPES.each { |type| option selected: store.get_node_parameter(props[:id], :type) == type do type end }
              end
            end
          end

          tr do
            td id: "input-#{props[:id]}-frequency" do
              '➤'
            end
            td do
              'Frequency'
            end
            td do
              input type: 'text', class: 'form-control input-sm pull-right', value: store.get_node_parameter(props[:id], :frequency), onchange: method(:change_frequency)
            end
          end

          tr do
            td id: "input-#{props[:id]}-detune" do
              '➤'
            end
            td do
              'Detune'
            end
            td do
              input type: 'text', class: 'form-control input-sm pull-right', value: store.get_node_parameter(props[:id], :detune), onchange: method(:change_detune)
            end
          end
        end
      end

      div class: 'panel-body text-center' do
        div class: 'btn-group' do
          button class: 'btn btn-primary btn-sm', onclick: method(:start) do
            'start'
          end
          button class: 'btn btn-primary btn-sm', onclick: method(:stop) do
            'stop'
          end
        end
      end
    end
  end
end

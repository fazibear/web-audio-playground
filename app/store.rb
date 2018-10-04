class Store
  include Inesita::Injection

  attr_reader :state

  def initialize
    storage = $window.storage(:audiostate)
    @audio = Browser::Audio::Context.new
    @nodes = {}

    @state = storage[:state] || {
      '0' => {
        id: '0',
        type: :destination,
        connections: [],
        parameters: {},
        y: 100,
        x: 600
      },
      '1' => {
        id: '1',
        type: :oscillator,
        connections: ['0'],
        parameters: {},
        x: 100,
        y: 100
      },
      '2' => {
        id: '2',
        type: :gain,
        connections: [['1', 'frequency']],
        parameters: {},
        x: 100,
        y: 400
      },
      '3' => {
        id: '3',
        type: :oscillator,
        connections: ['2'],
        parameters: {},
        x: 100,
        y: 400
      }
    }

    every(1) { storage[:state] = @state }

    @state.keys.each do |id|
      setup_node(id)
    end
  end

  def set_node_parameter(id, parameter, value)
    @state[id][:parameters][parameter] = value
    get_node(id).send("#{parameter}=", value)
  end

  def get_node_parameter(id, parameter)
    get_node(id).send(parameter)
  end

  def invoke_node_action(id, action, params = [])
    case action
    when :start
      get_node(id).send(action, *params)
    when :stop
      get_node(id).send(action, *params)
      setup_node(id)
    else
      get_node(id).send(action, *params)
    end
  end

  def connections
    connections = []
    @state.each do |id, node|
      node[:connections].each do |conn_id|
        conn_id = conn_id.join('-') if conn_id.is_a? Array
        connections << ["output-#{id}", "input-#{conn_id}"]
      end
    end
    connections
  end

  private

  def get_node(id)
    @nodes[id.to_s]
  end

  def setup_node(id)
    node_state = @state[id]

    @nodes[id] = node = @audio.send(node_state[:type])

    setup_node_parameters(node, node_state[:parameters])
    setup_node_connections(node, node_state[:connections])
  end

  def setup_node_parameters(node, parameters)
    parameters.each do |parameter, value|
      node.send("#{parameter}=", value)
    end
  end

  def setup_node_connections(node, connections)
    connections.each do |conn|
      if conn.is_a? Array
        node.connect(get_node(conn.first).send(conn.last, false))
      else
        node.connect(get_node(conn))
      end
    end
  end
end

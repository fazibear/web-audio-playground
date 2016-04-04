class NavBar
  include Inesita::Component

  def render
      div class: 'navbar navbar-default navbar-static-top' do
        div class: 'container-fluid' do
          div class: 'navbar-header' do
            a class: 'navbar-brand' do
              'Web Audio Show Case'
            end
          end
        end
      end
  end
end

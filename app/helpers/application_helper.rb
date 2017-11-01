module ApplicationHelper
  include ActionView::Helpers

  def flash_messages!
    output = flash.map do |type, massage|
      key = case type
              when 'notice'
                'success'
              when 'alert'
                'danger'
              else
                type
            end
      content_tag(:div, class: 'container', id: 'flash-messages' ) do
        content_tag(:div, class: "alert alert-#{key} text-center", role: 'alert') do
          concat(massage)
          concat(content_tag(:a, raw('&#215;'),  href: '#', class:'close', data: { dismiss: 'alert' } ))
        end
      end
    end.join
    raw(output)
  end

  def markup_for_admin
    user_signed_in? ? 'admin' : nil
  end
end

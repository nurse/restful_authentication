class <%= class_name %>Observer < ActiveRecord::Observer
<% if options[:include_activation] -%>
  def after_create(<%= file_name %>)
    <%= class_name %>Mailer.deliver_signup_notification(<%= file_name %>)
  end
<% end %>
  def after_save(<%= file_name %>)
    <% if options[:include_activation] %><%= class_name %>Mailer.deliver_activation(<%= file_name %>) if <%= file_name %>.recently_activated?<% end %>
    <% if options[:include_password_reset] %><%= class_name %>Mailer.deliver_password_reset_notification(<%= file_name %>) if <%= file_name %>.recently_password_reset_requested?<% end %>
  end
end

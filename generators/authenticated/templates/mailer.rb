class <%= class_name %>Mailer < ActionMailer::Base
<% if options[:include_activation] -%>
  def signup_notification(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += I18n.t('restful_authentication.activation_required_email_subject')
  <% if options[:include_activation] %>
    @body[:url]  = "http://YOURSITE/activate/#{<%= file_name %>.activation_code}"
  <% else %>
    @body[:url]  = "http://YOURSITE/login/" <% end %>
  end

  def activation(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += I18n.t('restful_authentication.activation_complete_email_subject')
    @body[:url]  = "http://YOURSITE/"
  end
<% end %><% if options[:include_password_reset] %>
  def password_reset_notification(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += I18n.t('restful_authentication.password_reset_email_subject')
    @body[:url]  = "http://YOURSITE/reset_password/#{<%= file_name %>.password_reset_code}"
  end
<% end %>
  protected
    def setup_email(<%= file_name %>)
      @recipients  = "#{<%= file_name %>.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:<%= file_name %>] = <%= file_name %>
    end
end

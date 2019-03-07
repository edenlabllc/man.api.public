defmodule Man.Repo.Migrations.FixEmployeeRegistrationAndInvitationEmailTemplates do
  use Ecto.Migration

  alias Man.Templates.API

  def change do
    API.update_template_body!(
      "Employee registration success notification",
      Application.app_dir(:man_api, "priv/static/employee_registration_success_notification.mustache")
    )
    
    API.update_template_body!(
      "Invitation email",
      Application.app_dir(:man_api, "priv/static/invitation_email.mustache")
    )
  end
end

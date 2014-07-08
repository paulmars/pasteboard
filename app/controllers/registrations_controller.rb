class RegistrationsController < Devise::RegistrationsController
  def new
    if (Rails.env.production? && params["pw"] == "paulismyfriend") || !Rails.env.production?
      super
    else
      render template: "registrations/ready", layout: "application"
    end
  end
end

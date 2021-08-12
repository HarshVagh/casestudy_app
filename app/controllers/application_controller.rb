class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
        end

        def after_sign_in_path_for(resource)
            case resource.roles.first.name
            when "candidate"
                candidate_dashboard_path
            when "assessor"
                assessor_dashboard_path
            when "admin"
                admin_dashboard_path
            else
                root_path
            end
        end
end

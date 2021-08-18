class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    #check_authorization

    # rescue_from CanCan::AccessDenied do |exception|
    #     redirect_to root_path, :alert => exception.message
    # end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
        end

        def after_sign_in_path_for(resource)
            if resource.roles.exists?(name: "admin")
                admin_dashboard_path
            elsif resource.roles.exists?(name: "assessor")
                assessor_dashboard_path
            elsif resource.roles.exists?(name: "candidate")
                candidate_dashboard_path
            else
                root_path
            end
        end
end

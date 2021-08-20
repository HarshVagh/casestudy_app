# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:4
    return unless user.present?

    can :contentcreator_dashboard, :dashboard if user.roles.exists?(name: "contentcreator")
    can :assessor_dashboard, :dashboard if user.roles.exists?(name: "assessor")
    can :candidate_dashboard, :dashboard if user.roles.exists?(name: "candidate")
    
    #user ||= User.new # guest user (not logged in)
    # if user.roles.first? :admin
    #   can :access, :admin_dashboard, user: user
    # elsif user.role? :assessor 
    #   can :access, :assessor_dashbord, user: user
    # elsif user.role? :candidate 
    #   can :access, :candidate_dashbord, user: user
    # end

    #can :manage, :all
    
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

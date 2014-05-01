class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
        # they get to do it all
        can :manage, :all

    elsif user.role? :instructor
        # can see a list of all users
        can :index, User
        can :index, Instructor
        can :index, Location

      
        # they can read their own user profile
        can :show, User do |u|
            u.id == user.id
        end

        # they can update their own profile
        can :update, User do |u|  
            u.id == user.id
        end

         # they can edit their own profile
        can :edit, User do |u|  
            u.id == user.id
        end

        # they can edit their own profile
        can :show, Instructor do |u|  
            u.id == user.instructor.id
        end

        can :update, Instructor do |u|  
            u.id == user.instructor.id
        end

        # they can edit their own profile
        can :edit, Instructor do |u|  
            u.id == user.instructor.id
        end
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end

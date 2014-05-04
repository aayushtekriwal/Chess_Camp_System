class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
        # they get to do it all
        can :manage, :all

    elsif user.role? :instructor
        # can see a list of all users
        can :index, Instructor
        can :index, Location
        can :index, Camp
        can :index, Curriculum
      
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

        # they can see/ read their own instructor profile
        can :show, Instructor do |u|  
            u.id == user.instructor.id
        end

        # they can update their own instructor profile
        can :update, Instructor do |u|  
            u.id == user.instructor.id
        end

        # they can edit their own instructor profile
        can :edit, Instructor do |u|  
            u.id == user.instructor.id
        end

        # they can see only their own camps
        can :show, Camp do |this_camp|
            taught_camps = user.instructor.camps.map(&:id)
            taught_camps.include? this_camp.id
        end

        # they can see only those students who they teach (students in their camps)
        can :show, Student do |this_student|
            taught_students = [] # initializing an empty array
            user.instructor.camps.each do |someCamp| # Iterates through each camp that the instructor teaches
                student_list = someCamp.students.map(&:id)
                student_list.each do |someStudentID| # Iterates through each student in each camp
                    taught_students.push(someStudentID) # Adds the student to the array
                end
            end
            taught_students.include? this_student.id # Checks if the student is in the taught_students array in order to grant access, or deny it
        end

        can :read, Location
        can :read, Camp
        can :read, Curriculum
    else
        # guests can only read domains covered (plus home pages)
        can :read, Location
        can :read, Camp
        can :read, Instructor
    end
  end
end

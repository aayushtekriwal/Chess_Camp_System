class DefaultAdmin < ActiveRecord::Migration
   def up
   	instructorSample = Instructor.new
   	instructorSample.first_name = "Aayush"
   	instructorSample.last_name = "Tekriwal"
   	instructorSample.phone = '4124632627'
   	instructorSample.email = "atekriwa@cmu.edu"
   	instructorSample.active = true
   	instructorSample.save!

    admin = User.new
    admin.username = "admin"
    admin.instructor = instructorSample
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.save!
  end

  def down
    admin = User.find_by_username "admin"
    User.delete admin
  end
end

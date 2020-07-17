class Student

    attr_accessor :name, :grade
    attr_reader :id

   def initialize(name, grade, id= nil)
       @id = nil
       @name = name
       @grade = grade
   end

  def self.create_table
      # creates the students table in the database
      sql =  <<-SQL
       CREATE TABLE IF NOT EXISTS students (
         id INTEGER PRIMARY KEY,
         name TEXT,
         grade TEXT
         )
         SQL
         # sql = "CREATE TABLE IF NOT EXISTS students (
         # id INTEGER PRIMARY KEY,
         # name TEXT,
         # age TEXT
         # )"
    DB[:conn].execute(sql)
  end

  def self.drop_table
      #  drops the students table from the database
      sql =  <<-SQL
       DROP TABLE students
         SQL

    DB[:conn].execute(sql)
end

def save
    # saves an instance of the Student class to the database
   sql = <<-SQL
     INSERT INTO students (name, grade)
     VALUES (?, ?)
   SQL

   DB[:conn].execute(sql, self.name, self.grade)
   # returns Nil
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    # now returns id- numeber(1)
 end

 def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
    # Student .create takes in a hash of attributes and uses metaprogramm
    # ing to create a new student object. hen it uses the #save method to save that student to
     # the database
  end

end

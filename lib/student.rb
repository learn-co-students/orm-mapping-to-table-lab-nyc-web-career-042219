class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id = 1, name, grade)
    @name = name
    @grade = grade
    @id = id
    # binding.pry
  end

  def self.create_table
    sql =<<-SQL
      CREATE TABLE students (  id INTEGER PRIMARY KEY,
       name TEXT,
       grade TEXT);
    SQL
     DB[:conn].execute(sql)

  end

  def self.drop_table
    sql =<<-SQL
      DROP TABLE students;
    SQL
     DB[:conn].execute(sql)

  end

  def save
    sql=<<-SQL
      INSERT INTO students (id, name, grade)
      VALUES (#{id}, "#{@name}", "#{@grade}");
      SQL
      # binding.pry
      DB[:conn].execute(sql)
    end

  def self.create(name:, grade:)
    newstudent=Student.new(name, grade)
    newstudent.save
    newstudent
  end
end

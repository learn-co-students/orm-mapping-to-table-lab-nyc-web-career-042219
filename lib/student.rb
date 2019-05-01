class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute(<<-SQL)
      DROP TABLE IF EXISTS students;
    SQL
  end

  def self.create(stu_hash)
    stu = Student.new(stu_hash[:name], stu_hash[:grade])
    stu.save
    stu
  end

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO 
        students(name, grade)
      VALUES(?, ?)
    SQL
    DB[:conn].execute(sql, name, grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
end

require_relative './relationships'

class Person
  include Relationships

  attr_reader :name, :gender
  attr_accessor :spouse, :mother

  def initialize(name, gender)
    @name = name
    @gender = gender
    @spouse = nil
    @mother = nil
  end

  def is_male?
    gender == 'Male'
  end

  def set_spouse(person)
    self.spouse = person
    person.spouse = self
  end

  def relationship(input_relation)
    relation = input_relation.gsub(/-/, '_').downcase
    send(relation)
  end
end

class Man < Person
  def initialize(name)
    @name = name
    @gender = 'Male'
  end
end

class Woman < Person
  attr_reader :children
  def initialize(name)
    @name = name
    @gender = 'Female'
    @children = []
  end

  def add_child(child)
    @children << child
    child.mother = self
  end
end
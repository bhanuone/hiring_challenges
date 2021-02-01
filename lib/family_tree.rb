# frozen_string_literal: true
require_relative './person'

PERSON_NOT_FOUND = 'PERSON_NOT_FOUND'
CHILD_ADDITION_FAILED = 'CHILD_ADDITION_FAILED'
CHILD_ADDITION_SUCCEEDED = 'CHILD_ADDITION_SUCCEEDED'
GET_RELATIONSHIP = 'GET_RELATIONSHIP'
ADD_CHILD = 'ADD_CHILD'
NONE = 'NONE'

class FamilyTree
  attr_reader :king, :queen
  def initialize
    @king = Man.new('King Shan')
    @queen = Woman.new('Queen Anga')
    @king.set_spouse(queen)
  end

  def get_relationship(person_name, relationship)
    person = find_member(person_name)
    return PERSON_NOT_FOUND if person.nil?
    result = person.relationship(relationship)
    if result.length == 0
      NONE
    else
      result.map(&:name).join(' ')
    end
  end

  def add_child(parent_name, child_name, child_gender)
    parent = find_member(parent_name)
    return PERSON_NOT_FOUND if parent.nil?
    if parent.is_a?(Man)
      return CHILD_ADDITION_FAILED
    else
      parent.add_child(get_child(child_name, child_gender))
      return CHILD_ADDITION_SUCCEEDED
    end
  end

  def call(args)
    case args[:action] 
    when ADD_CHILD
      add_child(args[:parent_name], args[:child_name], args[:child_gender])
    when GET_RELATIONSHIP
      get_relationship(args[:person_name], args[:relationship])
    else
      raise StandardError.new('Invalid Arguments Passed')
    end
  end

  def get_child(name, gender)
    if gender == 'Male'
      Man.new(name)
    else
      Woman.new(name)
    end
  end

  def find_member(name);
    member = nil
    queue = [king]
    visited = Set.new

    while queue.size > 0 do
      current = queue.shift
      if current.name == name
        member = current
        break;
      end
      if current.spouse
        if !visited.include?(current.spouse.name)
          queue << current.spouse
          current.children.each do |child|
            queue << child if !visited.include?(child.name)
          end
        end
      end
      visited.add(current.name)
    end

    member
  end

  # nocov
  def build
    %w(Chit Ish Vich Aras).each do |name|
      person = Man.new(name) 
      queen.add_child(person)
    end
    satya = Woman.new('Satya');
    queen.add_child(satya)
    satya.set_spouse(Man.new('Vyan'))

    amba = Woman.new('Amba')
    lika = Woman.new('Lika')
    chitra = Woman.new('Chitra')

    chit = find_member('Chit');
    amba.set_spouse(chit)

    vich = find_member('Vich')
    lika.set_spouse(vich)

    aras = find_member('Aras')
    chitra.set_spouse(aras)

    %w(Dritha Tritha).each {|name| amba.add_child(Woman.new(name))}
    vritha = Woman.new('Vritha')
    amba.add_child(vritha)

    jaya = Man.new('Jaya')
    dritha = find_member('Dritha')
    dritha.add_child(Man.new('Yodhan'))
    dritha.set_spouse(jaya)

    %w(Vila Chika).each { |name| lika.add_child(Woman.new(name))}

    jnki = Woman.new('Jnki')
    chitra.add_child(jnki)
    chitra.add_child(Man.new('Ahit'))
    jnki.set_spouse(Man.new('Arit'))
    jnki.add_child(Man.new('Laki'))
    jnki.add_child(Woman.new('Lavnya'))

    %w(Asva Vyas).each {|name| satya.add_child(Man.new(name))}

    asva = find_member('Asva')
    satvy = Woman.new('Satvy')
    asva.set_spouse(satvy)
    vasa = Man.new('Vasa')
    satvy.add_child(vasa)

    krpi = Woman.new('Krpi')
    vyas = find_member('Vyas')
    krpi.set_spouse(vyas)
    krpi.add_child(Man.new('Kriya'))
    krpi.add_child(Woman.new('Krithi'))

    satya.add_child(Woman.new('Atya'))
  end

  def self.init
    family = FamilyTree.new
    family.build
    family
  end
  # nocov

end
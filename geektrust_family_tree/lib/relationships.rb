# require 'pry-byebug'
module Relationships
  def father
    mother.spouse
  end

  def children
    is_male? ? spouse.children : children
  end

  def son
    children.select(&:is_male?)
  end

  def daughter
    children.select {|child| !child.is_male? }
  end

  def siblings
    mother ? mother.children - [self] : []
  end

  def brother_in_law
    (spouse ? spouse.siblings : []).select(&:is_male?) \
      + (mother ? mother.daughter.map(&:spouse).compact : [])
  end

  def sister_in_law
    (spouse ? spouse.siblings : []).select {|sibling| !sibling.is_male?} \
      + (mother ? mother.son.map(&:spouse).compact : [])
  end

  def maternal_aunt
    mother.siblings.select { |sibling| !sibling.is_male? }
  end

  def paternal_aunt
    father.siblings.select { |sibling| !sibling.is_male? }
  end

  def maternal_uncle
    mother.siblings.select(&:is_male?)
  end

  def paternal_uncle
    father.siblings.select(&:is_male?)
  end
end
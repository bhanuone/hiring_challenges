
"""
ADD_CHILD Mothers-Name Child's-Name Gender
ADD_CHILD Chitra Aria Female 

GET_RELATIONSHIP Lavnya Maternal-Aunt 
GET_RELATIONSHIP ”Name” “Relationship”

PERSON_NOT_FOUND
CHILD_ADDITION_FAILED
NONE
CHILD_ADDITION_SUCCEEDED

"""
require_relative './lib/family_tree'

def main
  input_file = ARGV[1]
  # parse the file and process the command
  # print the output
  family_tree = FamilyTree.init
  File.open(input_file).each_line do |args_str|
    begin
      args = parse_arguments(args_str)
      puts family_tree.call(args)
    rescue StandardError => e
      puts "Error: #{e.message}."
    end
  end
end


def parse_arguments(args_str)
  args = args_str.split
  if args[0] == 'ADD_CHILD'
    {action: 'ADD_CHILD', parent_name: args[1], child_name: args[2], child_gender: args[3]}
  elsif args[0] == 'GET_RELATIONSHIP'
    {action: 'GET_RELATIONSHIP', person_name: args[1], relationship: args[2]}
  else
  end
end
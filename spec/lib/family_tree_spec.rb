require_relative '../spec_helper'
describe FamilyTree do
  let(:family_tree) { FamilyTree.init }
  describe '#find_member' do
    context 'when a person is in the family' do
      it 'should return that person' do
        family_tree.add_child('Satvy', 'Ram', 'Male')
        expect(family_tree.find_member('Ram')).not_to be nil
      end
    end

    context 'when a person is not present in the family' do
      it 'should return nil' do
        person_name = 'Unknown'
        expect(family_tree.find_member(person_name)).to be nil
      end
    end
  end

  describe '#get_relationship' do
    context "when a person doesn't have people of given relation" do
      it 'should return NONE value' do
        result = family_tree.get_relationship('Jnki', 'Sister-In-Law')
        expect(result).to eq(NONE)
      end
    end

    context 'when a person have people of given relation' do
      it 'should return people names' do
        result = family_tree.get_relationship('Vyas', 'Siblings')
        expect(result).to eq('Asva Atya')
      end
    end

    context 'when the given person is not present in the family' do
      it 'should return PERSON_NOT_FOUND' do
        result = family_tree.get_relationship('Unknown', 'Sister-In-Law')
        expect(result).to eq(PERSON_NOT_FOUND)
      end
    end
  end

  describe '#add_child' do
    context 'when a child is added to family' do
      it 'should add return CHILD_ADDITION_SUCCEEDED' do
        allow(family_tree).to receive(:find_member).and_return build(:woman)
        allow_any_instance_of(Woman).to receive(:add_child).and_return nil
        result = family_tree.add_child('Mother', 'Child', 'Gender')

        expect(result).to eq CHILD_ADDITION_SUCCEEDED
      end
    end
    context 'when the given parent/mother is not present' do
      it 'should return PERSON_NOT_FOUND' do
        allow(family_tree).to receive(:find_member).and_return nil
        result = family_tree.add_child('Mother', 'Child', 'Gender')

        expect(result).to eq PERSON_NOT_FOUND
      end
    end
    context 'when the given parent is a male' do
      it 'should return CHILD_ADDITION_FAILED' do
        allow(family_tree).to receive(:find_member).and_return build(:man)
        result = family_tree.add_child('Mother', 'Child', 'Gender')

        expect(result).to eq CHILD_ADDITION_FAILED
      end
    end
  end

  describe '#call' do
    context 'when the action is ADD_CHILD' do
      it 'should call add_child' do
        args = {action: ADD_CHILD, child_name: 'child name', parent_name: 'Mother', child_gender: 'Male' }
        allow(family_tree).to receive(:add_child).and_return nil
        expect(family_tree).to receive(:add_child)

        family_tree.call(args)
      end
    end
    context 'when the action is GET_RELATIONSHIP' do
      it 'should call get_relationship' do
        args = {action: GET_RELATIONSHIP, person_name: 'Person', relationship: 'Son' }
        allow(family_tree).to receive(:get_relationship).and_return nil
        expect(family_tree).to receive(:get_relationship)

        family_tree.call(args)
      end
    end
    context 'when the action is invalid' do
      it 'should raise exception' do
        args = {action: 'Invalid'}
        expect { family_tree.call(args) }.to raise_error { StandardError }
      end
    end
  end

  describe '#get_child' do
    context 'when the person is a male' do
      it 'should return an instance of Male' do
        result = family_tree.get_child('Name', 'Male')
        expect(result).to be_a Man
      end
    end
    context 'when the person is a female' do
      it 'should return an instance of Female' do
        result = family_tree.get_child('Name', 'Female')
        expect(result).to be_a Woman
      end
    end
  end
end
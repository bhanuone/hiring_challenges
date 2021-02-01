require_relative '../spec_helper.rb';
describe Person do
  describe '#is_male?' do
    let(:person) {build(:person, {gender: 'Male'})} 
    let(:person_female) {build(:person, {gender: 'Female'})} 

    context 'when a person is male' do
      it 'should return true' do
        expect(person.is_male?).to be true
      end
    end

    context 'when a person is female' do
      it 'should return false' do
        expect(person_female.is_male?).to be false
      end
    end
  end

  describe '#set_spouse' do
    let(:queen) { build(:person, gender: 'Female') }
    let(:king) { build(:person, gender: 'Male') }
    before do
      queen.set_spouse(king)
    end

    it 'should make king as spouse to queen' do
      expect(queen.spouse).to eq(king)
    end
    it 'should make queen as spouse to king' do
      expect(king.spouse).to eq(queen)
    end
  end

  describe '#relationship' do
    # allow_any_instance_of(Woman).to receive(:brother_in_law).and_return([])
    let(:person) { build(:woman) }
    it 'should properly parse the input relation' do
      expect(person).to receive(:brother_in_law)
      person.relationship("Brother-In-Law")
    end
  end
end

describe Woman do
  let(:woman) { build(:woman) }

  describe '#add_child' do
    let(:child) { build(:man) }
    it 'should add a child to children' do
      woman.add_child(child)
      expect(woman.children).to include(child)
    end
  end

end

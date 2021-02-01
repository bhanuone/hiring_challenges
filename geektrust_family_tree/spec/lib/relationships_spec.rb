require_relative '../spec_helper.rb'
describe Relationships do
  let(:fathers_mother) { build(:woman) }
  let(:mothers_mother) { build(:woman) }
  let(:father) { build(:man) }
  let(:mother) { build(:woman) }
  let(:daughter) { build(:woman) }
  let(:son) { build(:man) }
  let(:paternal_uncle) { build(:man) }
  let(:paternal_uncle_wife) { build(:woman) }
  let(:maternal_uncle) { build(:man) }
  let(:maternal_uncle_wife) { build(:woman) }
  let(:paternal_aunt) { build(:woman) }
  let(:paternal_aunt_husband) { build(:man) }
  let(:maternal_aunt) { build(:woman) }
  let(:maternal_aunt_husband) { build(:man) }
  let(:sister_in_law) { build(:woman) }
  let(:brother_in_law) { build(:man) }

  before do
    # Father's family
    fathers_mother.add_child(father)
    fathers_mother.add_child(paternal_uncle)
    fathers_mother.add_child(paternal_aunt)
    paternal_aunt.set_spouse(paternal_aunt_husband)
    paternal_aunt.add_child(brother_in_law)
    paternal_uncle.set_spouse(paternal_uncle_wife)

    # Mother's family
    mothers_mother.add_child(mother)
    mothers_mother.add_child(maternal_uncle)
    maternal_uncle.set_spouse(maternal_uncle_wife)
    mothers_mother.add_child(maternal_aunt)
    maternal_aunt.add_child(sister_in_law)
    maternal_aunt.set_spouse(maternal_aunt_husband)

    # Family
    mother.set_spouse(father)
    mother.add_child(son)
    mother.add_child(daughter)
  end

  describe '#father' do
    it 'should return the father of a person' do
      expect(son.father).to eq(father)
    end
  end

  describe '#mother' do
    it 'should return the father of a person' do
      expect(daughter.mother).to eq(mother)
    end
  end

  describe '#paternal_uncle' do
    it 'should return the paternal uncle of a person' do
      expect(son.paternal_uncle).to include(paternal_uncle)
    end
  end

  describe '#maternal_uncle' do
    it 'should return the maternal uncle of a person' do
      expect(daughter.maternal_uncle).to include(maternal_uncle)
    end
  end

  describe '#paternal_aunt' do
    it 'should return the paternal aunt of a person' do
      expect(daughter.paternal_aunt).to include(paternal_aunt)
    end
  end

  describe '#maternal_aunt' do
    it 'should return the maternal aunt of a person' do
      expect(son.maternal_aunt).to include(maternal_aunt)
    end
  end

  describe '#sister_in_law' do
    context 'when the person is a female' do
      it 'should return the list of sister in laws of a person' do
        expect(mother.sister_in_law).to include(paternal_aunt, maternal_uncle_wife)
      end
    end
    context 'when the person is a male' do
      it 'should return the list of sister in laws of a person' do
        expect(father.sister_in_law).to include(maternal_aunt, paternal_uncle_wife)
      end
    end
  end

  describe '#brother_in_law' do
    context 'when the person is a female' do
      it 'should return the list of brother in laws of a person' do
        expect(mother.brother_in_law).to include(paternal_uncle, maternal_aunt_husband)
      end
    end

    context 'when the person is a male' do
      it 'should return the list of brother in laws of a person' do
        expect(father.brother_in_law).to include(maternal_uncle, paternal_aunt_husband)
      end
    end
  end

  describe '#son' do
    it 'should return the list sons of a person' do
      expect(father.son).to include(son)
    end
  end

  describe '#daughter' do
    it 'should return the list of daughters of a person' do
      expect(mother.daughter).to include(daughter)
    end
  end

  describe '#siblings' do
    it 'should return the list of siblings of a person' do
      expect(son.siblings).to include(daughter)
    end
  end
end
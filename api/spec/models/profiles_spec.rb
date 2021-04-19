require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validations' do
      it { is_expected.to validate_presence_of(:user_name) }
      it { is_expected.to validate_uniqueness_of(:user_name) }
  end
end


RSpec.describe Profile do

  let(:uui_name_tag) { SecureRandom.uuid}
  subject { Profile.create({user_name: uui_name_tag}) }
  
  context 'Instance' do
    it 'can be persisted' do
      expect(subject).to be_valid
    end

    it '#name shows user_name' do
      expect(subject.name).to include (uui_name_tag)
    end

  end

end
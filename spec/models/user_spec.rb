RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'User methods' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, author: user) }

    it 'check that user is question author' do
      expect(user.author_of?(question)).to be_truthy
    end

    it 'check that another user is not question author' do
      expect(another_user.author_of?(question)).to be_falsey
    end
  end
end

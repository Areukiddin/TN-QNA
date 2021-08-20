RSpec.describe Question, type: :model do
  it { should belong_to :author }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end

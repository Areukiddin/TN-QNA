RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'GET #show' do
    before { get :show, params: { id: answer.id } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
    it 'show needed answer' do
      expect(assigns(:answer)).to eq answer
    end
  end

  describe 'GET #new' do
    before { login(user) }

    before { get :new, params: { question_id: question.id } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
    it 'new instance of answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid params' do
      let(:valid_response) { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }

      it 'saves a new answer to database' do
        expect { valid_response }.to change(question.answers, :count).by(1)
      end
      it 'redirects to the current answer question' do
        valid_response
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid params' do
      let(:invalid_response) { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }

      it "doesn't save the answer to database" do
        expect { invalid_response }.to_not change(question.answers, :count)
      end
      it 're-render new view' do
        invalid_response
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #destroy' do
    let(:author) { create(:user) }
    let(:answer) { create(:answer, author: author) }
    let(:answer_destroy) { delete :destroy, params: { id: answer.id } }

    before { login(author) }

    it 'deletes the answer from database' do
      expect { answer_destroy }.to change(author.answers, :count).by(0)
    end
  end
end

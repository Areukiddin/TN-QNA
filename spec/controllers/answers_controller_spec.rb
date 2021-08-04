RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer) }

  describe 'GET #show' do
    before { get :show, params: { id: answer} }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question} }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_response) { post :create, params: { question_id: question, answer: attributes_for(:answer) } }

      it 'saves a new answer to database' do
        expect { valid_response }.to change(question.answers, :count).by(1)
      end
      it 'redirects to the current answer question' do
        valid_response
        expect(response).to redirect_to question_answers_path(assigns(:question))
      end
    end
    context 'with invalid params' do
      let(:invalid_response) { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }

      it "doesn't save the answer to database" do
        expect { invalid_response }.to_not change(question.answers, :count)
      end
      it 're-render new view' do
        invalid_response
        expect(response).to render_template :new
      end
    end
  end
end

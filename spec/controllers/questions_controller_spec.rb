RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET /#index' do
    let(:questions) { create_list(:question, 5) }

    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question} }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_response) { post :create, params: { question: attributes_for(:question) } }

      it 'saves a new question to database' do
        expect { valid_response }.to change(Question, :count).by(1)
      end
      it 'redirects to the question' do
        valid_response
        expect(response).to redirect_to assigns(:question)
      end
    end
    context 'with invalid params' do
      let(:invalid_response) { post :create, params: { question: attributes_for(:question, :invalid) } }

      it "doesn't save the question to database" do
        expect { invalid_response }.to_not change(Question, :count)
      end
      it 're-render new view' do
        invalid_response
        expect(response).to render_template :new
      end
    end
  end
end
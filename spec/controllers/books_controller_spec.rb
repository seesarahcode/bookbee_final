require 'spec_helper'

describe BooksController do

let(:valid_attributes) { { "title" => "The Stand" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GardensController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all gardens as @gardens" do
      book = Book.create! valid_attributes
      get :index, {}, valid_session
      assigns(:books).should eq([book])
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :show, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new, {}, valid_session
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :edit, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}, valid_session
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}, valid_session
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, {:book => valid_attributes}, valid_session
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => { "season" => "invalid value" }}, valid_session
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => { "season" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested garden" do
        garden = Garden.create! valid_attributes
        # Assuming there are no other gardens in the database, this
        # specifies that the Garden created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Garden.any_instance.should_receive(:update).with({ "season" => "MyString" })
        put :update, {:id => garden.to_param, :garden => { "season" => "MyString" }}, valid_session
      end

      it "assigns the requested garden as @garden" do
        garden = Garden.create! valid_attributes
        put :update, {:id => garden.to_param, :garden => valid_attributes}, valid_session
        assigns(:garden).should eq(garden)
      end

      it "redirects to the garden" do
        garden = Garden.create! valid_attributes
        put :update, {:id => garden.to_param, :garden => valid_attributes}, valid_session
        response.should redirect_to(garden)
      end
    end

    describe "with invalid params" do
      it "assigns the garden as @garden" do
        garden = Garden.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Garden.any_instance.stub(:save).and_return(false)
        put :update, {:id => garden.to_param, :garden => { "season" => "invalid value" }}, valid_session
        assigns(:garden).should eq(garden)
      end

      it "re-renders the 'edit' template" do
        garden = Garden.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Garden.any_instance.stub(:save).and_return(false)
        put :update, {:id => garden.to_param, :garden => { "season" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested garden" do
      garden = Garden.create! valid_attributes
      expect {
        delete :destroy, {:id => garden.to_param}, valid_session
      }.to change(Garden, :count).by(-1)
    end

    it "redirects to the gardens list" do
      garden = Garden.create! valid_attributes
      delete :destroy, {:id => garden.to_param}, valid_session
      response.should redirect_to(gardens_url)
    end
  end
end
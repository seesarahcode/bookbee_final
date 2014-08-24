require 'spec_helper'

describe User do
  before do
  	@user = User.new(name: "Jane Austen", email: "pride@prejudice.com",
  		password: "d4rcy5ucks", password_confirmation: "d4rcy5ucks")
  end

  subject { @user }

  it { should respond_to(:admin) }
  it { should respond_to(:books) }
  it { should respond_to(:reviews) }
  it { should respond_to(:feed) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token)}

  it { should be_valid }
  it { should_not be_admin }

  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid}
  end

  describe "when name is too long" do
  	before { @user.name = "S" * 51 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
      	@user.email = invalid_address
      	expect(@user).not_to be_valid
      end
  	end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is taken" do
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "book associations" do

    before { @user.save }
    let!(:older_book) do
      FactoryGirl.create(:book, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_book) do
      FactoryGirl.create(:book, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right books in the right order" do
      expect(@user.books.to_a).to eq [newer_book, older_book]
    end

    it "should destroy associated books" do
      books = @user.books.to_a
      @user.destroy
      expect(books).not_to be_empty
      books.each do |book|
        expect(Book.where(id: book.id)).to be_empty
      end
    end

     describe "status" do
      let(:unfollowed_book) do
        FactoryGirl.create(:book, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_book) }
      its(:feed) { should include(older_book) }
      its(:feed) { should_not include(unfollowed_book) }
    end
  end

end

require 'spec_helper'

describe Review do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }
  let(:review) { FactoryGirl.create(:review) }

  subject { @review }

	it { should respond_to(:title) }
	it { should respond_to(:text)}
	it { should respond_to(:fave_quote) }
  it { should respond_to(:user_id) }
  it { should respond_to(:book) }
  its(:user) { should eq user }
  its(:book) { should eq book }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @review.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when book_id is not present" do
  	before { @review.book_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank title" do
  	before { @review.title = " " }
  	it { should_not be_valid }
  end

  describe "with blank text" do
  	before { @review.text = " " }
  	it { should_not be_valid }
  end
end

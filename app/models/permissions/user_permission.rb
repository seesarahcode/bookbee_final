module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :users, [:new, :create, :edit, :update]
      allow :sessions, [:new, :create, :destroy]
      allow :books, [:index, :show, :new, :create]
      allow :books, [:edit, :update] do |book|
        book.user_id == user.id
      end
      allow :reviews, [:index, :show, :new, :create]
      allow :reviews, [:edit, :update] do |review|
        review.user_id == user.id
      end
      allow_param :book, :title
    end
  end
end
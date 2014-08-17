module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow :users, [:new, :create]
      allow :sessions, [:new, :create, :destroy]
      allow :books, :index
    end
  end
end
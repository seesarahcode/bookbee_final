module Permissions
  class AdminPermission < BasePermission
    def initialize(user)
      allow_all
      allow :users, [:new, :create, :edit, :update, :destroy, :admin, :blocked]
    end
  end
end
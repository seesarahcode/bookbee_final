class AddAdminToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :admin, :boolean, default: false
  end
end

class ChangePhoneNumberOfSupplier < ActiveRecord::Migration
  def change
    change_column :suppliers, :phone_number, :string
  end
end

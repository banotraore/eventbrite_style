class AddEventAdmninColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :admin, index: true
  end
end

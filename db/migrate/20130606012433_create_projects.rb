class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references  :binder
      t.references  :project_type
      t.references  :project_status
      t.string      :name
      t.string      :details
      t.date        :start_date
      t.date        :end_date
      t.money       :cost
      t.integer     :created_by
      t.timestamps
    end
  end
end

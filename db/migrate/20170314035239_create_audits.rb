class CreateAudits < ActiveRecord::Migration[5.1]
  def change
    create_table :audits do |t|
      t.references :auditable, polymorphic: true, index: true
      t.references :operator, polymorphic: true, index: true
      t.string :action
      t.text :audited_changes, limit: 4096
      t.string :note, limit: 1024
      t.datetime :created_at, index: true, null: false
    end
  end
end

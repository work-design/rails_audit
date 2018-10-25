class RailsAuditInit < ActiveRecord::Migration[5.1]
  def change

    create_table :audits do |t|
      t.references :auditable, polymorphic: true
      t.references :operator, polymorphic: true
      t.string :action
      t.string :audited_changes, limit: 4096
      t.string :related_changes, limit: 4096
      t.string :unconfirmed_changes, limit: 4096
      t.string :note, limit: 1024
      t.string :remote_ip
      t.string :controller_path
      t.string :action_name
      t.string :extra, limit: 4096
      t.datetime :created_at, index: true, null: false
    end

    create_table :checks do |t|
      t.references :checking, polymorphic: true
      t.references :operator, polymorphic: true
      t.string :state
      t.string :comment
      t.boolean :verified

      t.timestamps
    end

    create_table :check_settings do |t|
      t.references :checking, polymorphic: true
      t.string :code

      t.timestamps
    end

  end
end

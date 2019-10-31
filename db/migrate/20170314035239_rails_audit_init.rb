class RailsAuditInit < ActiveRecord::Migration[5.1]
  def change

    create_table :audits do |t|
      t.references :audited, polymorphic: true
      t.references :operator, polymorphic: true
      t.string :action
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :audited_changes
        t.jsonb :related_changes
        t.jsonb :unconfirmed_changes
        t.jsonb :extra
      else
        t.json :audited_changes
        t.json :related_changes
        t.json :unconfirmed_changes
        t.json :extra
      end
      t.string :note, limit: 1024
      t.string :remote_ip
      t.string :controller_path
      t.string :action_name
      t.datetime :created_at, index: true, null: false
    end

    create_table :checks do |t|
      t.references :checking, polymorphic: true
      t.references :operator, polymorphic: true
      t.string :state
      t.string :comment
      t.boolean :confirmed, default: true
      t.timestamps
    end

    create_table :check_settings do |t|
      t.references :checking, polymorphic: true
      t.string :code
      t.timestamps
    end

  end
end

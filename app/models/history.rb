class History < ActiveRecord::Base
  paginates_per 10

  belongs_to :wiki
  belongs_to :knowledge
  belongs_to :commit, class_name: 'User', foreign_key: 'commit_id'
  validates :commit_id, presence: true
  validates :active, uniqueness: { scope: :knowledge_id }

  enum status: [:status_initial, :status_passed]

  default_scope -> { order(id: :desc) }
  def set_active
    self.class.where.not(id: self.id).where(knowledge_id: self.knowledge_id).update_all(active: false)
    self.update(active: true)
    move_to_wiki
  end

end

# :item_id, :integer
# :user_id, :integer
# :content, :string, limit: 65535
# :commit_id, :integer
# :commit_message, :string

t.integer  "wiki_id",        limit: 4
t.integer  "knowledge_id",   limit: 4
t.text     "body",           limit: 65535
t.string   "commit_message", limit: 4096
t.datetime "created_at"
t.datetime "updated_at"
t.integer  "commit_id",      limit: 4
t.boolean  "active",                       default: false
t.integer  "status",         limit: 4,     default: 0
t.string   "type",           limit: 255

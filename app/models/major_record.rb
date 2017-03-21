class MajorRecord < ApplicationRecord

  belongs_to :knowledge, counter_cache: true

  def move_to_wiki
    wiki = knowledge.major || knowledge.build_major
    wiki.commit_id = self.commit_id
    wiki.commit_message = self.commit_message
    wiki.body = self.body
    wiki.save
  end

end


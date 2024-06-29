module Batch
  class DataReset
    def self.data_reset
      user = User.find_by(email: "guest@example.com")
      user.posts.destroy_all
      user.post_comments.destroy_all
      user.groups.destroy_all
    end
  end
end

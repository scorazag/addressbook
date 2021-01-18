class Organizacion < ApplicationRecord
    has_many :user
    def user_count
        self.user.size
    end
end

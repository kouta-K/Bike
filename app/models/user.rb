class User < ApplicationRecord
    attr_accessor :activation_token, :reset_token
    before_save {self.email = email.downcase}
    before_create :create_activation_digest
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    validates :age, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 18}
    has_secure_password
    
    has_many :favorites
    has_many :has_favorites, through: :favorites, source: :micropost
    has_many :microposts
    has_many :people, class_name: "Member"
    has_many :groups
    has_many :send_messages , class_name: "Message"
    has_many :participates
    has_many :participate_plan, through: :participates, source: :plan
    
    has_many :notifications
    has_many :visited_user, class_name: "Notification", foreign_key: "visited_id"
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :followed
    has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id"
    has_many :followers, through: :reverse_relationships, source: :user
    
    mount_uploader :image, ImageUploader
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def self.new_token
        SecureRandom.urlsafe_base64()
    end
    
    
    def authenticated?(token)
        BCrypt::Password.new(activation_digest).is_password?(token)
    end
    
    def reset_authenticated?(token)
        BCrypt::Password.new(reset_digest).is_password?(token)
    end
    
    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end
    
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end
    
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end
    
    def follow(user)
       @relationship = self.relationships.build(followed_id: user.id)
       @relationship.save
       self.notifications.create(visited_id: user.id, relationship_id: @relationship.id, action: "フォロー")
    end
     
    
    def unfollow(user)
        @relationship = self.relationships.find_by(followed_id: user.id)
        @relationship.destroy
    end
    
    def following?(user)
        self.followings.include?(user)
    end
    
    private 
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end

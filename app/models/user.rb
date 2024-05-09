class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :email, presence: true
  validates :name, presence: true
  validates :is_active, presence: true
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  
  def self.looks(word)
    if word == ""
      User.all
    else
      User.where('name LIKE ?', "%#{word}%")
    end
  end  
  
  GUEST_USER_EMAIL = "guest@example.com"
  
    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "guestuser"
      end
    end
    
    def guest_user?
      email == GUEST_USER_EMAIL
    end   
    

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  has_many :sns_credentials, dependent: :destroy
  has_many :cards
  has_many :comments
  has_many :exhibits
  has_many :likes
  has_many :users, through: :users_historys
  has_many :users_historys
  has_one :address

  validates :nickname, presence: true, length: {minimum: 4 , maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, uniqueness: true  
  validates :year, presence: true
  validates :month, presence: true 
  validates :day, presence: true 

  validates :first_name_kanji, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :family_name_kanji, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/}


  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first #firstをつけないとデータが配列で返されて使いたいメソッドが使えなくて困る

    #sns_credentialsが登録されている
    if snscredential.present?
      user = User.where(email: auth.info.email).first

      # userが登録されていない
      unless user.present?
        user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        )
      end
      sns = snscredential
      #返り値をハッシュにして扱いやすくする  
      #活用例 info = User.find_oauth(auth) 
            #session[:nickname] = info[:user][:nickname]
      { user: user, sns: sns}

    #sns_credentialsが登録されていない
    else
      user = User.where(email: auth.info.email).first


      # userが登録されている
      if user.present?
        sns = SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )

        { user: user, sns: sns}

      # userが登録されていない
      else
        user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider
        )

        { user: user, sns: sns}
      end
    end
  end
end
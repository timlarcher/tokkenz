class Player < ActiveRecord::Base

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :password
  attr_accessible :admin, :first_name, :last_name, :handle, :email, :password, :password_confirmation

  validates :first_name, :presence => true,
                         :length => {:maximum => 50}
  validates :last_name, :presence => true,
                        :length => {:maximum => 50}
  validates :handle, :presence => true,
                     :length => {:maximum => 50},
                     :uniqueness => {:case_sensitive=>false}
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive=>false}
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}

  before_save :encrypt_password

  has_many :packs
  has_many :stores
  has_many :tokens
  has_many :trades
  has_many :bids

  # Attempts to match handle to either name or email.
  # If finds a match, verifies password and
  # returns player or nil.
  def self.authenticate( handle, password )
    if player = Player.find_by_handle(handle)
      return player if player.has_password?(password)
    end
    if player = Player.find_by_email(handle)
      return player if player.has_password?(password)
    end
    return nil
  end

  def self.authenticate_with_salt( id, salt )
    player = Player.find_by_id(id)
    ( player && player.password_salt == salt ) ? player : nil
  end

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

private

  def encrypt_password
    self.password_salt = make_salt if new_record?
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(pwd)
    Digest::SHA2.hexdigest( "#{self.password_salt}--#{pwd}")
  end

  def make_salt
    Digest::SHA2.hexdigest( "#{Time.now.utc}--#{self.password}")
  end
end

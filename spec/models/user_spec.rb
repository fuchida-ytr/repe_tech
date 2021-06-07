require 'rails_helper'

RSpec.describe User, type: :model do
	# 姓、名、メール、パスワードがあれば有効な状態であること
	it "is valid with a first name, last name, email, and password" do
    user = User.new(
      name: "Aaron",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
		)
    expect(user).to be_valid # モデルが有効な状態かチェック
  end
end
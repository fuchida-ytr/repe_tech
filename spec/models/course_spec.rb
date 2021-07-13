require 'rails_helper'

RSpec.describe Course, type: :model do

  # title, captionがあれば有効な状態であること
  it "is valid with a title, caption" do
    course = Course.new(
      title: "Ruby",
      caption: "ver.2.6.7"
    )
    expect(course).to be_valid
  end

  # titleがなければ無効な状態であること
  it "is invalid without a title" do
    course = Course.new(title: nil)
    course.valid?
    expect(course.errors[:title]).to include("が入力されていません。")
  end
end
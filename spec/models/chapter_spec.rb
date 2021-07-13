require 'rails_helper'

RSpec.describe Chapter, type: :model do

  # TODO: データの準備をDRY
  # titleがあれば有効な状態であること
  it "is valid with a title" do
    course = Course.create(
      title: "Ruby"
    )
    chapter = course.chapters.build(
      title: "Ruby",
      course_id: 1
    )
    expect(chapter).to be_valid
  end

  # titleがなければ無効な状態であること
  it "is invalid without a title" do
    course = Course.create(
      title: "Ruby"
    )
    chapter = course.chapters.build(
      title: nil,
      course_id: 1
      )
    chapter.valid?
    expect(chapter.errors[:title]).to include("が入力されていません。")
  end
end

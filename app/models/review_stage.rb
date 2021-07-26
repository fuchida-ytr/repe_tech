class ReviewStage < ApplicationRecord
  # t.integer "stage"
  # t.integer "after_days"
  # t.integer "user_id"

  # validation
  validates :stage, presence: true
  validates :after_days, presence: true
  validates :user_id, presence: true

  belongs_to :user

  # ユーザーの全ステージを昇順で取得
  def self.get_user_stages(user_id)
    where(user_id: user_id).order(:stage)
  end

  # [{stage.stage: todays_section_num}]
  def self.get_review_list_by_stage(user_id, course)
    # 復習予定の全sectinoを取得
    user_review_sections = ReviewSection.where(user_id: user_id)
                                        .where(section_id: course.get_section_ids)
                                        .where('next_review_date <= ?', Date.current)

    # ユーザーの全ステージを取得
    stages = get_user_stages(user_id)

    # ステージごとのセクション数
    review_list_by_stage = {} # {stage: secton数,}
    # stage1(review_stage_id:nil)の今日のsection
    # todays_review_list_by_stage[1] = user_review_sections.where(review_stage_id: nil).count
    # それ以降のstage
    stages.each do |stage|
      review_list_by_stage[stage] = user_review_sections.where(review_stage_id: stage.id).count
    end
    review_list_by_stage
  end

  def self.get_next_stage(user_id, stage_id)
    stages = get_user_stages(user_id)

    if stage_id
      current_stage = find(stage_id)
      next_stage = stages.find_by(stage: current_stage.stage + 1)
    else # stage_id:nil つまり stage1のとき
      next_stage = stages.find_by(stage: 2)
    end
    next_stage
  end

  def self.get_stage_1_id(user_id)
    where(user_id: user_id).find_by(stage: 1).id
  end
end

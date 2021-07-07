class ReviewStagesController < ApplicationController
  def index
    @stages = current_user.review_stages
    @stage = current_user.review_stages.build
    @next_stage = (@stages.maximum(:stage) || 1) + 1
  end

  def create
    @stage = current_user.review_stages.build(review_stage_params)
    # TODO: ステージの値が正しいかチェック
    @stage.save!
    redirect_to review_stages_path, notice: '作成しました'
  end

  def update
    @review_stage = ReviewStage.find(params[:id])
    if @review_stage.update(review_stage_params)
      redirect_to review_stages_path, notice: '更新しました'
    else
      render 'index'
    end
  end

  def destroy
    @review_stage = ReviewStage.find(params[:id])
    @review_stage.destroy
    redirect_to review_stages_path, notice: '削除しました'
    # TODO: 該当するステージのセクションのステージを１ステージ下げる
    # @memory_stage = MemoryStage.find(params[:id])
    # @memories = @memory_stage.memory_group.memories.where(stage: @memory_stage.stage)
    # if  @memory_stage.destroy
    # 	@memories.update_all(:stage => @memory_stage.stage-1)
  end

  private

  def review_stage_params
    params.require(:review_stage).permit(:stage, :after_days, :user_id)
  end
end

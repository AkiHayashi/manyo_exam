require 'rails_helper'
RSpec.describe 'Label Function', type: :system do
  let!(:second_label){ FactoryBot.create(:second_label)}
  user = FactoryBot.create(:user)
  let!(:task){FactoryBot.create(:task, user: user)}
  before do 
    visit new_session_path
    fill_in "session[email]", with:"user@ex.jp"
    fill_in "session[password]", with:"11111111"
    find(".login_btn").click
    visit tasks_path
  end
  describe 'create new task with label' do
    it 'show opition to select the label' do
      visit new_task_path
      fill_in "task[title]", with: "test task title"
      fill_in "task[description]", with: "test description"
      select '着手中' , from: "task[progress]"
      fill_in "task[expired_at]", with: DateTime.current.strftime("%Y\t%m%d%I%M%P")
      select '中' , from: "task[priority]"
      expect(page).to have_content "test_label"
      check 'test_label'
      click_on "登録する"
      expect(page).to have_content "タスク作成完了"
    end
  end
  describe 'edit label of task' do
    it 'label changeable from user show page' do
    visit tasks_path
    expect(page).to have_content "test_label"
    find(".show-btn#{task.id}").click
    click_on '編集'
    uncheck 'test_label'
    click_on '更新する'
    find(".show-btn#{task.id}").click
    expect(page).not_to have_content "test_label"
    end
  end
  describe 'serching by label' do
    it 'find labeled tasks out' do
      visit new_task_path
      fill_in "task[title]", with: "test task title"
      fill_in "task[description]", with: "test description"
      select '着手中' , from: "task[progress]"
      fill_in "task[expired_at]", with: DateTime.current.strftime("%Y\t%m%d%I%M%P")
      select '中' , from: "task[priority]"
      check 'test_label2'
      click_on "登録する"
      visit tasks_path
      select 'test_label' , from: "label_ids"
      click_on "検索"
      find(".show-btn#{task.id}").click
      expect(page).to have_content "test_label"
    end
  end
end


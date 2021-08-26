require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "test task title"
        fill_in "task[description]", with: "test description"
        click_on "Create Task"
        expect(page).to have_content "タスク作成完了"
        expect(page).to have_content "test task title"
        expect(page).to have_content "test description"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content "タスク一覧"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task1 = FactoryBot.create(:task, title: 'テスト用タスク1')
        FactoryBot.create(:task, title: 'task2')
        visit tasks_path
        # all('tbody tr td')[2].click_on '詳細'
        find(".show-btn#{task1.id}").click
        expect(page).to have_content 'テスト用タスク1'
       end
     end
  end
end
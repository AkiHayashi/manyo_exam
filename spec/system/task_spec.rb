require 'rails_helper'
def basic_pass(path)
  username = ENV["USER"] 
  password = ENV["PASS"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { 
    FactoryBot.create(:task, title: 'タスク１')
    FactoryBot.create(:task, title: 'タスク２')
    FactoryBot.create(:task, title: 'タスク３') 
  }
  before do 
    basic_pass visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "test task title"
        fill_in "task[description]", with: "test description"
        click_on "登録する"
        expect(page).to have_content "タスク作成完了"
        expect(page).to have_content "test task title"
        expect(page).to have_content "test description"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'タスク１'
        expect(page).to have_content "タスク一覧"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row').collect(&:text)
        task_list[0] < task_list[1] || task_list[1] < task_list[2]
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task1 = FactoryBot.create(:task, title: '詳細表示機能テスト用タスク')
        FactoryBot.create(:task, title: 'task2')
        basic_pass visit tasks_path
        #all('tbody tr td')[2].click_on '詳細'
        find(".show-btn#{task1.id}").click
        expect(page).to have_content '詳細表示機能テスト用タスク'
      end
    end
  end
end
require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_NAME"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { 
    FactoryBot.create(:task, title: 'タスク１', progress: "未着手", priority:"低", expired_at: DateTime.new.strftime('2021-09-03 00:00:00'))
    FactoryBot.create(:task, title: 'タスク２', progress: "着手中", priority:"中", expired_at: DateTime.new.strftime('2021-09-02 00:00:00'))
    FactoryBot.create(:task, title: 'タスク３', progress: "完了", priority:"高", expired_at: DateTime.new.strftime('2021-09-01 00:00:00')) 
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
        select '着手中' , from: "task[progress]"
        fill_in "task[expired_at]", with: DateTime.current.strftime("%Y\t%m%d%I%M%P")
        click_on "登録する"
        expect(page).to have_content "タスク作成完了"
        expect(page).to have_content "test task title"
        expect(page).to have_content "test description"
        expect(page).to have_content "着手中"
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
        task_list = all('.task_row_created').collect(&:text)
        task_list[0] < task_list[1] || task_list[1] < task_list[2]
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の遅いタスクが一番上に表示される' do
        find(".sort_expired_btn").click
        task_list = all('.task_row_expired').collect(&:text)
        expect(task_list[2]).to have_content "09/01"
        task_list[0] > task_list[1] || task_list[1] > task_list[2]
      end
    end
    context 'タスクが優先順位の高い順に並んでいる場合' do
      it '優先順位の高いタスクが一番上に表示される' do
        find(".sort_priority_btn").click
        task_list = all('.task_row_priority').collect(&:text)
        expect(task_list[0]).to have_content "高"
      end
    end
  end
  describe '検索機能' do
    context '任意のタイトルで検索した場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'title', with: "タスク１"
        click_on "検索"
        expect(page).to have_content "タスク１"
        expect(page).not_to have_content "タスク２" && "タスク３"
      end
    end
    context '任意のステータスで検索した場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中' , from: "progress"
        click_on "検索"
        expect(find('.task_row_progress')).to have_content "着手中"
        expect(find('.task_row_progress')).not_to have_content "未着手" && "完了"
      end
    end
    context '任意のタイトルとステータスの両方で検索した場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'title', with: "タスク１"
        select '未着手' , from: "progress"
        click_on "検索"
        expect(page).to have_content "タスク１"
        expect(page).not_to have_content "タスク２" && "タスク３"
        expect(find('.task_row_progress')).to have_content "未着手"
        expect(find('.task_row_progress')).not_to have_content "着手中" && "完了"
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
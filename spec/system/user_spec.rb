require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_NAME"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end
RSpec.describe 'user function', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:admin_user){FactoryBot.create(:admin_user)}
  before do
    basic_pass visit root_path
  end
  describe 'user registration ' do
    context 'register new user' do
      it 'show new user page' do
        visit new_user_path
        fill_in "user[user_name]", with: "ユーザー2"
        fill_in "user[email]", with: "user2@ex.jp"
        fill_in "user[password]", with: "11111111"
        fill_in "user[password_confirmation]", with: "11111111"
        click_on "アカウントを作成する"
        expect(page).to have_content "ユーザー登録が完了しました"
        expect(page).to have_content "ユーザー2のページ"
      end
    end
    context 'can not access tasks index without login' do
      it 'link to login screen wihtout ' do 
        visit tasks_path
        expect(page).to have_content "ログイン"
        fill_in "session[email]", with:"user@ex.jp"
        fill_in "session[password]", with:"11111111"
        find(".login_btn").click
        visit tasks_path
        expect(page).to have_content "タスク一覧"
      end
    end
  end
  describe 'session function' do
    context 'user can login and visit own page' do 
      it 'show user page' do 
        visit new_session_path
        expect(page).to have_content "ログイン"
        fill_in "session[email]", with:"user@ex.jp"
        fill_in "session[password]", with:"11111111"
        find(".login_btn").click
        visit "users/#{user.id}"
        expect(page).to have_content "ユーザー1のページ"
      end
    end
    context 'not accessible to other user page' do
      it 'show error message' do
        fill_in "session[email]", with:"user@ex.jp"
        fill_in "session[password]", with:"11111111"
        find(".login_btn").click
        visit "users/#{user.id + 1}"
        expect(page).to have_content "権限がありません"
        expect(page).to have_content "タスク一覧"
      end
    end
    context 'logout' do
      it 'show message to tell user logged out and require login when you try to link to the tasks index page' do
        fill_in "session[email]", with:"user@ex.jp"
        fill_in "session[password]", with:"11111111"
        find(".login_btn").click
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました"
        visit tasks_path
        expect(page).to have_content "ログイン"
      end
    end
  end
  describe 'admin user function' do
    before do
      visit new_session_path
      fill_in "session[email]", with:"admin@ex.jp"
      fill_in "session[password]", with:"11111111"
      find(".login_btn").click
    end
    context 'accessible to the page only admin user can accesses' do 
      it 'show user index' do
        visit admin_users_path
        expect(page).to have_content "ユーザー管理画面"
        expect(page).to have_content "ユーザー1"
      end
    end
    context 'general user cannot accseess to the admin page' do 
      it 'show error massege' do
        click_on "ログアウト"
        fill_in "session[email]", with:"user@ex.jp"
        fill_in "session[password]", with:"11111111"
        find(".login_btn").click
        visit admin_users_path
        expect(page).to have_content "管理者権限がありません"
      end
    end
    context 'admin user can register new user' do
      it 'show message to tell new user was successfuly created' do
        visit new_admin_user_path
        fill_in "user[user_name]", with: "ユーザー2"
        fill_in "user[email]", with: "user2@ex.jp"
        fill_in "user[password]", with: "11111111"
        fill_in "user[password_confirmation]", with: "11111111"
        click_on "アカウントを作成する"
        expect(page).to have_content "ユーザー登録が完了しました"
        expect(page).to have_content "ユーザー2"
      end
    end
    context 'admin user can access othe user page' do
      it 'show other user information' do 
        visit "users/#{admin_user.id - 1}"
        expect(page).to have_content "ユーザー1"
      end
    end
    context 'admin user can edit other user information' do
      it 'change other user name' do
        visit admin_users_path
        find(".edit_btn#{user.id}").click
        fill_in "user[user_name]", with: "test"
        fill_in "user[password]", with: "11111111"
        fill_in "user[password_confirmation]", with: "11111111"
        click_on "更新する"
        expect(page).to have_content "ユーザー情報を更新しました"
        expect(page).to have_content "test"
      end
    end
    context 'admin user can delete other user' do 
      it 'disapper the user that admin user delete' do 
        visit admin_users_path
        find(".delete_btn#{user.id}").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ユーザーを削除しました"
      end
    end
  end
end
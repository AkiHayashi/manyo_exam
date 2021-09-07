require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', description: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'タスクテスト', description: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:model_test_user1)
        task = Task.new(title:'タスクテスト', description:'成功テスト', expired_at: DateTime.new + 10, progress: "未着手", priority:"低",  user: user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    user = FactoryBot.create(:model_test_user2)
    let!(:task) { FactoryBot.create(:task, title: 'task', progress:"未着手", user: user)}
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample", progress:"着手中", user: user)}
    let!(:third_task) { FactoryBot.create(:third_task, title: "task", progress:"完了", user: user)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).to include(third_task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.progress('未着手')).to include(task)
        expect(Task.progress('未着手')).not_to include(second_task)
        expect(Task.progress('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_like('task').progress('未着手')).to include(task)
        expect(Task.title_like('task').progress('未着手')).not_to include(third_task)
        expect(Task.title_like('task').progress('未着手').count).to eq 1
      end
    end
  end
end
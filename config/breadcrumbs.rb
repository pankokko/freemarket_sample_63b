crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :mypage_edit do
  link "プロフィール", edit_user_path(current_user)
  parent :mypage
end

crumb :mypage_selling do
  link "購入した商品 - 取引中", selling_user_path(current_user)
  parent :mypage
end

crumb :mypage_card do
  link "支払い方法", card_user_path(current_user)
  parent :mypage
end

crumb :mypage_regi_card do
  link "クレジットカード情報入力", regi_card_user_path(current_user)
  parent :mypage_card
end

crumb :mypage_identification do
  link "本人情報の登録", identification_user_path(current_user)
  parent :mypage
end

crumb :mypage_logout do
  link "ログアウト", logout_user_path(current_user)
  parent :mypage
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
class Status < ActiveHash::Base
  self.data = [
    {status: '新品、未使用'},
    {status: '未使用に近い'},
    {status: '目立った傷や汚れ無し'},
    {status: 'やや傷や汚れあり'},
    {status: '傷や汚れあり'},
    {status: '全体的に状態が悪い'},
  ]
end
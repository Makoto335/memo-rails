3.times do |number|
  Memo.create(content: "#{number}番目のメモです！", user_id: User.first.id)
  puts "#{number}番目のメモを作成しました"
end

puts "メモの作成が完了しました"

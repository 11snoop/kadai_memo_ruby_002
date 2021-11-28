require "csv"
 
puts "1(新規でメモを作成) 2(既存のメモ編集する)"
 
memo_type = gets.to_i
#1(新規でメモを作成)
if memo_type == 1 then
    puts "拡張子を除いたファイル名を入力してください"
    
    new_file = gets.to_s.chomp#.chomp追記
    
    p "メモしたい内容を記入してください"
    p "完了したらCtrl + dをおします"
    
    new_memo = STDIN.read.chomp
    
    CSV.open("#{new_file}.csv","w", :quote_char => '') do |csv|
    csv << ["#{new_memo}"]
    end
#2(既存のメモ編集する)
elsif memo_type == 2 then
    puts "拡張子を除いた既存のファイル名を入力してください"
    
    existing_file = gets.to_s.chomp#.chomp追記
    
    p "既存のメモ内容"
    
    existing_memo = CSV.read("#{existing_file}.csv")
    puts existing_memo
    
    puts "1(メモ削除) 2(メモ編集) 3(メモ追記)"
    
    existing_memo_type = gets.to_i
    
    #1(メモ削除)
    if existing_memo_type == 1 then
        p "削除したい箇所は上から何段目ですか？"
        p "※一段目は『0』から開始となります"
        
        delete_memo_type = gets.chomp
        
        data = CSV.read("#{existing_file}.csv")
        data["#{delete_memo_type}".to_i] = []
        CSV.open("#{existing_file}.csv","w"){|f| data.each{|x| f << x} }

    #2(メモ編集)
    elsif existing_memo_type == 2 then
        p "編集したい箇所は上から何段目ですか？"
        p "※一段目は『0』から開始となります"
        
        edit_memo_type = gets.chomp
        
        p "編集したい内容を記入してください"
        p "完了したらCtrl + dをおします"
        
        edit_memo = STDIN.read.chomp
        
        data = CSV.read("#{existing_file}.csv")
        data["#{edit_memo_type}".to_i] = ["#{edit_memo}"]
        CSV.open("#{existing_file}.csv","w"){|f| data.each{|x| f << x} }
    
    #3(メモ追記)
    elsif existing_memo_type == 3 then
        p "追記したい内容を記入してください"
        p "完了したらCtrl + dをおします"
    
        postscript_memo = STDIN.read.chomp
    
        CSV.open("#{existing_file}.csv","a", :quote_char => '') do |csv|
        csv << ["#{postscript_memo}"]
        end
    end
end
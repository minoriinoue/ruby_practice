# encoding: utf-8
#
# 実行結果：
# Encoded by base64: 5LqV5LiK44G/44Gu44KK
# Decoded by base64: 井上みのり
#
# encode64が何かわからなかったので調べてみましたが、
# 「Base64 は、3 オクテット (8bits * 3 = 24bits) の
# バイナリコードを ASCII 文字のうちの 65 文字 
# ([A-Za-z0-9+/] の 64 文字と '=') だけを使用して 
# 4 オクテット (6bits * 4 = 24bits) の印字可能文字列
# に変換するエンコーディング法」
# とあり、理解できなかった。
# 64文字は2^6に対応しているので、変換後の6bits * 4という
# のは、変換後は64文字の中から１つ(6bit) * 4文字で元々の
# 文字を表すということでしょうか？
# 確かに、元々の漢字の数(5)から4倍(20)になっている。
# 説明の後半はこの理解で合っているような気がするのだが、
# 前半の「3 オクテット (8bits * 3 = 24bits) のバイナリ
# コードを」という意味って普通のASCII256文字(2^8)を
# 3個並べているのが元々の「井上みのり」という文字
# ということになると思うのですが、どうなっているのだろう、。

require 'base64'

name = '井上みのり'
enc = Base64.encode64(name)
puts "Encoded by base64: #{enc}"
original = Base64.decode64(enc)
puts "Decoded by base64: #{original}"


# docker-jumanpp
Docker上でJuman++を使うためのイメージ.  
主なインストール: Juman, Juman++, KNP, pyknp  

## 使用方法
### イメージファイルの作成
```
docker build -t juman_image ./
```
### コンテナの立ち上げ
```
docker run --name juman_container --rm -it juman_image
```
### サンプル
python上でをJuman++を使う
```python
from pyknp import Juman
jumanpp = Juman()
mlist = jumanpp.analysis('大きな力で空に浮かべたら,ルララ宇宙の風に乗る')
mlist = [mrph.midasi for mrph in mlist.mrph_list()]
# ['大きな', '力', 'で', '空', 'に', '浮かべたら', ',', 'ルララ', '宇宙', 'の', '風', 'に', '乗る']
```

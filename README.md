# ObservableValue

各プロパティが変更通知可能なオブジェクト

## install

https://www.npmjs.com/package/amo.modules.observable_value

```
npm install --save-dev amo.modules.observable_value
```

## 使い方

```coffeescript
ObservableValue = require "amo.modules.observable_value"

obj = ObservableValue.create()

listener = (old, newValue) ->
  console.log old, newValue

obj.register "hoge", listener
obj.addProperty("hoge", "fizz")
obj.hoge = "buzz"  # listener が呼ばれ、"fizz" "buzz" と表示される

# 複数プロパティを同時に登録することも可能
obj.addProperties
  hoge: "fuga"
  fizz: "buzz"

# 新規作成時に登録することも可能
obj = ObservableValue.create
  hoge: "fuga"
  fizz: "buzz"

# "addProperty", "addProperties", "register", "publish" は登録出来ないので注意
obj.addProperty "addProperty", "hoge"
console.log obj.addProperty  # function
```



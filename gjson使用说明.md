GJSON 是一个 Go 包，它提供了一种[快速](https://github.com/tidwall/gjson/blob/master/README.md#performance)[而简单的](https://github.com/tidwall/gjson/blob/master/README.md#get-a-value)方法来从 json 文档中获取值。它具有[单行检索](https://github.com/tidwall/gjson/blob/master/README.md#get-a-value)，[点表示法路径](https://github.com/tidwall/gjson/blob/master/README.md#path-syntax)，[迭代](https://github.com/tidwall/gjson/blob/master/README.md#iterate-through-an-object-or-array)和分析[json行](https://github.com/tidwall/gjson/blob/master/README.md#json-lines)等功能。

另请查看 [SJSON](https://github.com/tidwall/sjson) 以修改 json，以及 [JJ](https://github.com/tidwall/jj) 命令行工具。

本自述文件是有关如何使用 GJSON 的快速概述，有关更多信息，请查看 [GJSON 语法](https://github.com/tidwall/gjson/blob/master/SYNTAX.md)。

GJSON也可用于[蟒蛇](https://github.com/volans-/gjson-py)和[鲁斯特](https://github.com/tidwall/gjson.rs)

## 1 安装

要开始使用 GJSON，请安装 Go 并运行 ：`go get`

```bash
$ go get -u github.com/tidwall/gjson
```

这将检索库。

## 2 获取值

获取指定路径的搜索 json。路径采用点语法，例如“name.last”或“年龄”。找到该值后，将立即返回该值。

```go
package main

import "github.com/tidwall/gjson"

const json = `{"name":{"first":"Janet","last":"Prichard"},"age":47}`

func main() {
	value := gjson.Get(json, "name.last")
	println(value.String())
}
```

这将打印：

```
Prichard
```

*还有用于一次获取多个值[的 GetMany](https://github.com/tidwall/gjson/blob/master/README.md#get-multiple-values-at-once) 函数，以及用于处理 JSON 字节切片的 [GetBytes](https://github.com/tidwall/gjson/blob/master/README.md#working-with-bytes)。*

## 3 路径语法

以下是路径语法的快速概述，有关更完整的信息，请查看[GJSON语法](https://github.com/tidwall/gjson/blob/master/SYNTAX.md)。

路径是由点分隔的一系列键。键可能包含特殊的通配符“*”和“？”。要访问数组值，请使用索引作为键。若要获取数组中的元素数或访问子路径，请使用“#”字符。点和通配符可以用“\”转义。

```json
{
  "name": {"first": "Tom", "last": "Anderson"},
  "age":37,
  "children": ["Sara","Alex","Jack"],
  "fav.movie": "Deer Hunter",
  "friends": [
    {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
    {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
    {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
  ]
}
"name.last"          >> "Anderson"
"age"                >> 37
"children"           >> ["Sara","Alex","Jack"]
"children.#"         >> 3
"children.1"         >> "Alex"
"child*.2"           >> "Jack"
"c?ildren.0"         >> "Sara"
"fav\.movie"         >> "Deer Hunter"
"friends.#.first"    >> ["Dale","Roger","Jane"]
"friends.1.last"     >> "Craig"
```

还可以使用 查询数组中的第一个匹配项，或使用 查找的所有匹配项。查询支持 、 、 、 、 比较运算符和简单模式匹配 （like） 和 （不喜欢） 运算符。`#(...)``#(...)#``==``!=``<``<=``>``>=``%``!%`

```json
friends.#(last=="Murphy").first    >> "Dale"
friends.#(last=="Murphy")#.first   >> ["Dale","Jane"]
friends.#(age>45)#.last            >> ["Craig","Murphy"]
friends.#(first%"D*").last         >> "Murphy"
friends.#(first!%"D*").last        >> "Craig"
friends.#(nets.#(=="fb"))#.first   >> ["Dale","Roger"]
```

*请注意，在 v1.3.0 之前，查询使用 `#[...]` 括号。这在 v1.3.0 中进行了更改，以避免与新的[多路径](https://github.com/tidwall/gjson/blob/master/SYNTAX.md#multipaths)语法混淆。为了向后兼容，`#[...]` 将继续工作，直到下一个主要版本。*

## 4 结果类型
GJSON 支持 json 类型、、 和 。数组和对象作为其原始 json 类型返回。`string``number``bool``null`
该类型包含以下类型之一：`Result`

```json
bool, for JSON booleans
float64, for JSON numbers
string, for JSON string literals
nil, for JSON null
```
要直接访问该值，请执行以下操作：
```json
result.Type           // can be String, Number, True, False, Null, or JSON
result.Str            // holds the string
result.Num            // holds the float64 number
result.Raw            // holds the raw json
result.Index          // index of raw value in original json, zero means index unknown
result.Indexes        // indexes of all the elements that match on a path containing the '#' query character.
```

有各种方便的函数可以处理结果：

```json
result.Exists() bool
result.Value() interface{}
result.Int() int64
result.Uint() uint64
result.Float() float64
result.String() string
result.Bool() bool
result.Time() time.Time
result.Array() []gjson.Result
result.Map() map[string]gjson.Result
result.Get(path string) Result
result.ForEach(iterator func(key, value Result) bool)
result.Less(token Result, caseSensitive bool) bool
```

该函数返回 需要类型断言的 函数，并且是以下 Go 类型之一：`result.Value()``interface{}`

```json
boolean >> bool
number  >> float64
string  >> string
null    >> nil
array   >> []interface{}
object  >> map[string]interface{}
```

该函数返回一个值数组。如果结果表示不存在的值，则将返回一个空数组。如果结果不是 JSON 数组，则返回值将是包含一个结果的数组。`result.Array()`

### 4.1 位整数

和 调用能够读取所有 64 位，从而允许使用较大的 JSON 整数。`result.Int()``result.Uint()`
```
result.Int() int64    // -9223372036854775808 to 9223372036854775807
result.Uint() int64   // 0 to 18446744073709551615
```

## 5 修饰符和路径链接

版本 1.2 中的新功能是支持修饰符函数和路径链接。
修饰符是对 json 执行自定义处理的路径组件。
可以使用管道字符将多个路径“链接”在一起。这对于从修改后的查询中获取结果非常有用。
例如，使用上述 json 文档中的内置修饰符，我们将获取数组并反转顺序：`@reverse``children`

```
"children|@reverse"           >> ["Jack","Alex","Sara"]
"children|@reverse|0"         >> "Jack"
```
目前有以下内置修饰符：
- `@reverse`：反转数组或对象的成员。
- `@ugly`：从 json 文档中删除所有空格。
- `@pretty`：使 json 文档更易于阅读。
- `@this`：返回当前元素。它可用于检索根元素。
- `@valid`：确保 json 文档有效。
- `@flatten`：拼合数组。
- `@join`：将多个对象联接到单个对象中。
- `@keys`：返回对象的键数组。
- `@values`：返回对象的值数组。
- `@tostr`：将 json 转换为字符串。包装 json 字符串。
- `@fromstr`：转换来自 json 的字符串。解开 json 字符串的包装。
- `@group`：对对象数组进行分组。见 [e4fc67c](https://github.com/tidwall/gjson/commit/e4fc67c92aeebf2089fabc7872f010e340d105db)。

### 5.1 修饰符参数
修饰符可以接受可选参数。该参数可以是有效的 JSON 文档，也可以只是字符。
例如，修饰符将 json 对象作为其参数。`@pretty`
```
@pretty:{"sortKeys":true} 
```

这使得json很漂亮，并订购了所有密钥。

```json
{
  "age":37,
  "children": ["Sara","Alex","Jack"],
  "fav.movie": "Deer Hunter",
  "friends": [
    {"age": 44, "first": "Dale", "last": "Murphy"},
    {"age": 68, "first": "Roger", "last": "Craig"},
    {"age": 47, "first": "Jane", "last": "Murphy"}
  ],
  "name": {"first": "Tom", "last": "Anderson"}
}
```

*`@pretty`选项的完整列表包括`排序键`、`缩进`、`前缀`和`宽度`。请参阅[漂亮的选项](https://github.com/tidwall/pretty#customized-output)以获取更多信息。*

### 5.2 自定义修饰符

您还可以添加自定义修饰符。

例如，在这里我们创建一个修饰符，使整个 json 文档大写或小写。

```go
gjson.AddModifier("case", func(json, arg string) string {
  if arg == "upper" {
    return strings.ToUpper(json)
  }
  if arg == "lower" {
    return strings.ToLower(json)
  }
  return json
})
"children|@case:upper"           >> ["SARA","ALEX","JACK"]
"children|@case:lower|@reverse"  >> ["jack","alex","sara"]
```

## 6 JSON 行

支持使用前缀的 [JSON 行](http://jsonlines.org/)，它将多行文档视为数组。`..`

例如：

```json
{"name": "Gilbert", "age": 61}
{"name": "Alexa", "age": 34}
{"name": "May", "age": 57}
{"name": "Deloise", "age": 44}
..#                   >> 4
..1                   >> {"name": "Alexa", "age": 34}
..3                   >> {"name": "Deloise", "age": 44}
..#.name              >> ["Gilbert","Alexa","May","Deloise"]
..#(name="May").age   >> 57
```

该函数将循环访问 JSON 行。`ForEachLines`

```go
gjson.ForEachLine(json, func(line gjson.Result) bool{
    println(line.String())
    return true
})
```

## 7 获取嵌套数组值

假设您想要以下 json 中的所有姓氏：

```json
{
  "programmers": [
    {
      "firstName": "Janet", 
      "lastName": "McLaughlin", 
    }, {
      "firstName": "Elliotte", 
      "lastName": "Hunter", 
    }, {
      "firstName": "Jason", 
      "lastName": "Harold", 
    }
  ]
}
```

你可以使用路径“程序员.#.lastName”，如下所示：

```
result := gjson.Get(json, "programmers.#.lastName")
for _, name := range result.Array() {
	println(name.String())
}
```

您还可以查询数组中的对象：

```
name := gjson.Get(json, `programmers.#(lastName="Hunter").firstName`)
println(name.String())  // prints "Elliotte"
```

## 8 循环访问对象或数组

该函数允许快速迭代对象或数组。键和值将传递给对象的迭代器函数。仅为数组传递该值。从迭代器返回将停止迭代。`ForEach``false`

```go
result := gjson.Get(json, "programmers")
result.ForEach(func(key, value gjson.Result) bool {
	println(value.String()) 
	return true // keep iterating
})
```

## 9 简单的解析和获取

有一个函数可以执行简单的解析，并会搜索结果。`Parse(json)``result.Get(path)`

例如，所有这些将返回相同的结果：

```go
gjson.Parse(json).Get("name").Get("last")
gjson.Get(json, "name").Get("last")
gjson.Get(json, "name.last")
```

## 10 检查值是否存在
有时您只想知道某个值是否存在。
```go
value := gjson.Get(json, "name.last")
if !value.Exists() {
	println("no last name")
} else {
	println(value.String())
}

// Or as one step
if gjson.Get(json, "name.last").Exists() {
	println("has a last name")
}
```

## 11 验证 JSON

和 函数期望 json 格式正确。错误的 json 不会崩溃，但它可能会返回意外的结果。`Get*``Parse*`

如果您使用来自不可预知源的 JSON，则可能需要在使用 GJSON 之前进行验证。

```go
if !gjson.Valid(json) {
	return errors.New("invalid json")
}
value := gjson.Get(json, "name.last")
```

## 12 转为 map 类型
要取消封印到一个：`map[string]interface{}`
```go
m, ok := gjson.Parse(json).Value().(map[string]interface{})
if !ok {
	// not a map
}
```

## 13 使用字节

如果你的 JSON 包含在切片中，则存在[“获取字节”](https://godoc.org/github.com/tidwall/gjson#GetBytes)函数。这比 更可取。`[]byte``Get(string(data), path)`

```go
var json []byte = ...
result := gjson.GetBytes(json, path)
```

如果您正在使用该函数，并且希望避免转换为 ，则可以使用以下模式：`gjson.GetBytes(json, path)``result.Raw``[]byte`

```go
var json []byte = ...
result := gjson.GetBytes(json, path)
var raw []byte
if result.Index > 0 {
    raw = json[result.Index:result.Index+len(result.Raw)]
} else {
    raw = []byte(result.Raw)
}
```

This is a best-effort no allocation sub slice of the original json. This method utilizes the field, which is the position of the raw data in the original json. It's possible that the value of equals zero, in which case the is converted to a .`result.Index``result.Index``result.Raw``[]byte`

## 14 Get multiple values at once

The function can be used to get multiple values at the same time.`GetMany`

```
results := gjson.GetMany(json, "name.first", "name.last", "age")
```

The return value is a , which will always contain exactly the same number of items as the input paths.`[]Result`

## 15 性能

GJSON 的基准以及[编码/json](https://golang.org/pkg/encoding/json/)、[ffjson](https://github.com/pquerna/ffjson)、[易捷生](https://github.com/mailru/easyjson)、[jsonparser](https://github.com/buger/jsonparser) 和 [json-iterator](https://github.com/json-iterator/go)

```
BenchmarkGJSONGet-16                11644512       311 ns/op       0 B/op	       0 allocs/op
BenchmarkGJSONUnmarshalMap-16        1122678      3094 ns/op    1920 B/op	      26 allocs/op
BenchmarkJSONUnmarshalMap-16          516681      6810 ns/op    2944 B/op	      69 allocs/op
BenchmarkJSONUnmarshalStruct-16       697053      5400 ns/op     928 B/op	      13 allocs/op
BenchmarkJSONDecoder-16               330450     10217 ns/op    3845 B/op	     160 allocs/op
BenchmarkFFJSONLexer-16              1424979      2585 ns/op     880 B/op	       8 allocs/op
BenchmarkEasyJSONLexer-16            3000000       729 ns/op     501 B/op	       5 allocs/op
BenchmarkJSONParserGet-16            3000000       366 ns/op      21 B/op	       0 allocs/op
BenchmarkJSONIterator-16             3000000       869 ns/op     693 B/op	      14 allocs/op
```

使用的 JSON 文档：

```
{
  "widget": {
    "debug": "on",
    "window": {
      "title": "Sample Konfabulator Widget",
      "name": "main_window",
      "width": 500,
      "height": 500
    },
    "image": { 
      "src": "Images/Sun.png",
      "hOffset": 250,
      "vOffset": 250,
      "alignment": "center"
    },
    "text": {
      "data": "Click Here",
      "size": 36,
      "style": "bold",
      "vOffset": 100,
      "alignment": "center",
      "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
    }
  }
}    
```



每个操作都通过以下搜索路径之一进行轮换：

```
widget.window.name
widget.image.hOffset
widget.text.onMouseUp
```

*这些基准测试是在使用 Go 1.17 的 MacBook Pro 16“2.4 GHz 英特尔酷睿 i9 上运行的，可以[在这里](https://github.com/tidwall/gjson-benchmarks)找到。*

# 路径语法

GJSON 路径是一种文本字符串语法，用于描述从 JSON 有效负载快速检索值的搜索模式。
最终的实现是 [github.com/tidwall/gjson](https://github.com/tidwall/gjson)。
使用 [GJSON 游乐场](https://gjson.dev/)在线试验语法。

## 1 路径结构

GJSON 路径旨在轻松表示为由字符分隔的一系列组件。`.`

除了字符之外，还有一些具有特殊含义，包括 、 、 、 、 、 和 。`.``|``#``@``\``*``!``?`

## 2 例

给定此 JSON

```
{
  "name": {"first": "Tom", "last": "Anderson"},
  "age":37,
  "children": ["Sara","Alex","Jack"],
  "fav.movie": "Deer Hunter",
  "friends": [
    {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
    {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
    {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
  ]
}
```

以下 GJSON 路径的计算结果为随附的值。

### 2.1 基本

在许多情况下，您只需要按对象名称或数组索引重取值。

```
name.last              "Anderson"
name.first             "Tom"
age                    37
children               ["Sara","Alex","Jack"]
children.0             "Sara"
children.1             "Alex"
friends.1              {"first": "Roger", "last": "Craig", "age": 68}
friends.1.first        "Roger"
```

### 2.2 通配符

键可以包含特殊的通配符和 。将匹配任何零 +字符，并匹配任何一个字符。`*``?``*``?`

```
child*.2               "Jack"
c?ildren.0             "Sara"
```

### 2.3 转义字符

特殊用途的字符，如 、 和 ，可以使用 进行转义。`.``*``?``\`

```
fav\.movie             "Deer Hunter"
```

您还需要确保在源代码中对路径进行硬编码时正确转义该字符。`\`

```
// Go
val := gjson.Get(json, "fav\\.movie")  // must escape the slash
val := gjson.Get(json, `fav\.movie`)   // no need to escape the slash 
// Rust
let val = gjson::get(json, "fav\\.movie")     // must escape the slash
let val = gjson::get(json, r#"fav\.movie"#)   // no need to escape the slash 
```

### 2.4 阵 列

该字符允许深入研究 JSON 数组。`#`

要获得数组的长度，您只需使用 all 本身。`#`

```
friends.#              3
friends.#.age         [44,68,47]
```

### 2.5 查询

还可以使用 查询数组中的第一个匹配项，或使用 查找的所有匹配项。查询支持 、 、 、 、 比较运算符以及简单模式匹配（如）和（不喜欢）运算符。`#(...)``#(...)#``==``!=``<``<=``>``>=``%``!%`

```
friends.#(last=="Murphy").first     "Dale"
friends.#(last=="Murphy")#.first    ["Dale","Jane"]
friends.#(age>45)#.last             ["Craig","Murphy"]
friends.#(first%"D*").last          "Murphy"
friends.#(first!%"D*").last         "Craig"
```

若要查询数组中的非对象值，可以放弃运算符右侧的字符串。

```
children.#(!%"*a*")                 "Alex"
children.#(%"*a*")#                 ["Sara","Jack"]
```

允许嵌套查询。

```
friends.#(nets.#(=="fb"))#.first  >> ["Dale","Roger"]
```

*请注意，在 v1.3.0 之前，查询使用 `#[...]` 括号。这在 v1.3.0 中进行了更改，以避免与新的[多路径](https://github.com/tidwall/gjson/blob/master/SYNTAX.md#multipaths)语法混淆。为了向后兼容，`#[...]` 将继续工作，直到下一个主要版本。*

（波浪号）运算符将在比较之前将值转换为布尔值。`~`

例如，使用以下 JSON：

```
{
  "vals": [
    { "a": 1, "b": true },
    { "a": 2, "b": true },
    { "a": 3, "b": false },
    { "a": 4, "b": "0" },
    { "a": 5, "b": 0 },
    { "a": 6, "b": "1" },
    { "a": 7, "b": 1 },
    { "a": 8, "b": "true" },
    { "a": 9, "b": false },
    { "a": 10, "b": null },
    { "a": 11 }
  ]
}
```

您现在可以查询所有真值或假值：

```
vals.#(b==~true)#.a    >> [1,2,6,7,8]
vals.#(b==~false)#.a   >> [3,4,5,9,10,11]
```

最后一个不存在的值被视为`false`

### 2.6 点与管

是标准分隔符，但也可以使用 .在大多数情况下，它们最终都会返回相同的结果。与不同的情况是，在[数组](https://github.com/tidwall/gjson/blob/master/SYNTAX.md#arrays)和[查询](https://github.com/tidwall/gjson/blob/master/SYNTAX.md#queries)之后使用它。`.``|``|``.``#`

以下是一些示例

```
friends.0.first                     "Dale"
friends|0.first                     "Dale"
friends.0|first                     "Dale"
friends|0|first                     "Dale"
friends|#                           3
friends.#                           3
friends.#(last="Murphy")#           [{"first": "Dale", "last": "Murphy", "age": 44},{"first": "Jane", "last": "Murphy", "age": 47}]
friends.#(last="Murphy")#.first     ["Dale","Jane"]
friends.#(last="Murphy")#|first     <non-existent>
friends.#(last="Murphy")#.0         []
friends.#(last="Murphy")#|0         {"first": "Dale", "last": "Murphy", "age": 44}
friends.#(last="Murphy")#.#         []
friends.#(last="Murphy")#|#         2
```

让我们分解其中的一些。

路径本身就会导致`friends.#(last="Murphy")#`

```
[{"first": "Dale", "last": "Murphy", "age": 44},{"first": "Jane", "last": "Murphy", "age": 47}]
```

在返回结果*之前*，后缀将处理每个数组元素上的路径。这成为`.first``first`

```
["Dale","Jane"]
```

但后缀实际上处理上一个结果*之后*的路径。由于前面的结果是数组，而不是对象，因此无法处理，因为 不存在。`|first``first``first`

然而，后缀返回`|0`

```
{"first": "Dale", "last": "Murphy", "age": 44}
```

因为是上一个结果的第一个索引。`0`

### 2.7 修饰 符

修饰符是对 JSON 执行自定义处理的路径组件。

例如，在上面的 JSON 负载上使用内置修饰符将反转数组：`@reverse``children`

```
children.@reverse                   ["Jack","Alex","Sara"]
children.@reverse.0                 "Jack"
```

目前有以下内置修饰符：

- `@reverse`：反转数组或对象的成员。
- `@ugly`：从 JSON 中删除所有空格。
- `@pretty`：使 JSON 更易于阅读。
- `@this`：返回当前元素。它可用于检索根元素。
- `@valid`：确保 json 文档有效。
- `@flatten`：拼合数组。
- `@join`：将多个对象联接到单个对象中。
- `@keys`：返回对象的键数组。
- `@values`：返回对象的值数组。
- `@tostr`：将 json 转换为字符串。包装 json 字符串。
- `@fromstr`：转换来自 json 的字符串。解开 json 字符串的包装。
- `@group`：对对象数组进行分组。见 [e4fc67c](https://github.com/tidwall/gjson/commit/e4fc67c92aeebf2089fabc7872f010e340d105db)。

#### 2.7.1 修饰符参数

修饰符可以接受可选参数。该参数可以是有效的 JSON 有效负载，也可以只是字符。

例如，修饰符将 json 对象作为其参数。`@pretty`

```
@pretty:{"sortKeys":true}
```

这使得json很漂亮，并订购了所有密钥。

```
{
  "age":37,
  "children": ["Sara","Alex","Jack"],
  "fav.movie": "Deer Hunter",
  "friends": [
    {"age": 44, "first": "Dale", "last": "Murphy"},
    {"age": 68, "first": "Roger", "last": "Craig"},
    {"age": 47, "first": "Jane", "last": "Murphy"}
  ],
  "name": {"first": "Tom", "last": "Anderson"}
}
```

*`@pretty`选项的完整列表包括`排序键`、`缩进`、`前缀`和`宽度`。请参阅[漂亮的选项](https://github.com/tidwall/pretty#customized-output)以获取更多信息。*

#### 2.7.2 自定义修饰符

您还可以添加自定义修饰符。

例如，在这里我们创建一个修饰符，使整个 JSON 有效负载大写或小写。

```
gjson.AddModifier("case", func(json, arg string) string {
  if arg == "upper" {
    return strings.ToUpper(json)
  }
  if arg == "lower" {
    return strings.ToLower(json)
  }
  return json
})
"children.@case:upper"             ["SARA","ALEX","JACK"]
"children.@case:lower.@reverse"    ["jack","alex","sara"]
```

*注意：自定义修饰符在 Rust 版本中尚不可用*

### 2.8 多路径

从 v1.3.0 开始，GJSON 添加了将多个路径连接在一起以形成新文档的功能。在 或 之间包装逗号分隔的路径将分别生成新的数组或对象。`[...]``{...}`

例如，使用给定的多路径：

```
{name.first,age,"the_murphys":friends.#(last="Murphy")#.first}
```

在这里，我们为姓氏为“墨菲”的朋友选择了名字，年龄和名字。

您会注意到，可以提供可选键（在本例中为“the_murphys”）以强制将键分配给值。否则，将使用实际字段的名称，在本例中为“first”。如果无法确定名称，则使用“_”。

这导致

```
{"first":"Tom","age":37,"the_murphys":["Dale","Jane"]}
```

### 2.9 文字

从 v1.12.0 开始，GJSON 添加了对 json 文本的支持，这为构造 json 的静态块提供了一种方法。这在使用[多路径](https://github.com/tidwall/gjson/blob/master/SYNTAX.md#multipaths)构造新的 json 文档时特别有用。

json 文本以“！”声明字符开头。

例如，使用给定的多路径：

```
{name.first,age,"company":!"Happysoft","employed":!true}
```



在这里，我们选择了名字和年龄。然后添加两个新字段，“公司”和“雇用”。

这导致

```
{"first":"Tom","age":37,"company":"Happysoft","employed":true}
```

*有关 JSON 文本的其他上下文，请参阅问题 [#249](https://github.com/tidwall/gjson/issues/249)。*

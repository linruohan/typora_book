# gpui使用

 
## 1 gpui
https://github.com/zed-industries/zed 中的一个crate 
 创建者的快速、高效的 Rust UI 框架 来自 Zed 。 

## 2 gpui-component
https://github.com/longbridge/gpui-component
> 这仍处于开发的早期阶段，我们可能会频繁更改 API。
> 但是这些功能可以使用，您必须持续跟踪我们的更改。

用于使用 [GPUI]（https://gpui.rs） 构建出色桌面应用程序的 UI 组件。
### 2.1 功能
- Theming
- TitleBar
- Dock, Tiles
- TextInput, TextArea, OtpInput
- Button, Link
- Label
- Icon
- Checkbox, Radio, Switch
- Dropdown
- Tabs
- Notification
- Tooltip
- Popover
- Resizable
- Progress & Indicator
- Slider
- Skeleton
- DatePicker, DateRangePicker, Calendar
- ColorPicker
- List
- Table
- Menu
- Drawer
- Modal
- WebView
- Accordion
- Sidebar
- Breadcrumb
- Badge
- TextView (Markdown, Simple HTML) to native rendering, syntax highlighting.
- Toggle, ToggleGroup


### 2.2 展示柜
这是第一个应用程序：[Longbridge]（https://longbridge.com） 它是使用 GPUI 组件构建的。
> 它仍在开发中，尚未发布。

<img width=“2017” alt=“SCR-20250107-kagq” src=“https://github.com/user-attachments/assets/55f9e012-34ce-44d1-908f-768f8d2c8abf” />
<img width=“2017” alt=“SCR-20250107-kaky” src=“https://github.com/user-attachments/assets/a56995ca-1c54-43bb-9a27-bc9023a169dd” />
<img width=“2017” alt=“SCR-20250107-kapd” src=“https://github.com/user-attachments/assets/ecdfe8cd-f8d8-4df4-bafe-ab2d8517f8db” />
<img width=“2017” alt=“SCR-20250107-kfvk” src=“https://github.com/user-attachments/assets/ccc4f25f-16c2-4140-a2ad-d194aadaa544” />

我们在应用程序中构建了多主题支持，此功能不包含在 GPUI 组件中。它基于“主题”功能，因此很容易做到。
### 2.3 用法
GPUI 和 GPUI 组件仍在开发中，因此我们需要通过 git 添加依赖项。
GPUI 组件依赖于特殊版本的 'gpui' （它一直更新到上游） 来包含 WebView 支持。
```TOML
gpui = { git = “https://github.com/huacnlee/zed.git”， branch = “webview” }
gpui-component = { git = “https://github.com/longbridge/gpui-component.git” }
```
### 2.4 网页视图
GPUI 组件具有基于 [Wry]（https://github.com/tauri-apps/wry） 的 'WebView' 元素，这是一个可选功能，你可以通过功能标志来启用它。

```TOML
gpui-component = { git = “https://github.com/longbridge/gpui-component.git”， features = [“webview”] }
```

更多用法可以在 [story]（https://github.com/longbridge/gpui-component/tree/main/crates/story） 目录中找到。
### 2.5 图标

GPUI 组件具有 'Icon' 元素，但默认情况下它不包含 SVG 文件。

这个例子是使用 [Lucide]（https://lucide.dev） 图标，但你可以使用任何你喜欢的图标，只需命名 svg 文件，比如 [IconName]（https://github.com/longbridge/gpui-component/blob/main/crates/ui/src/icon.rs#L86） 定义了路径名。
您可以在项目中添加所需的图标。

### 2.6 演示
如果您想观看演示，这里有一些演示应用程序。
- [gpui-app-windows.zip]（https://github.com/user-attachments/files/17396296/gpui-app-windows.zip） - 更新于 2024/10/16
### 2.7 开发

更多示例可以在 'examples' 目录中找到。
查看 [DEVELOPMENT]（DEVELOPMENT） 查看更多详细信息。
### 2.8 许可证
```
## License

Apache-2.0

- UI design based on [shadcn/ui](https://ui.shadcn.com).
- Icon from [Lucide](https://lucide.dev).
```
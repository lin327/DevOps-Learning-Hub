<p align="center">
  <img src="https://avatars0.githubusercontent.com/u/44036562?s=100&v=4"/> 
</p>

## Starter Workflows

这些是帮助用户快速上手 GitHub Actions 的工作流文件。当你开始创建新的 GitHub Actions 工作流时，系统会展示这些模板。

**如果你想开始使用 GitHub Actions，可以在你想要创建工作流的仓库中点击 "Actions" 选项卡来使用这些入门工作流。**

<img src="https://d3vv6lp55qjaqc.cloudfront.net/items/353A3p3Y2x3c2t2N0c01/Image%202019-08-27%20at%203.25.07%20PM.png" max-width="75%"/>

### 注意

感谢你对这个 GitHub 仓库的关注，但目前我们暂不接受外部贡献。

我们将继续把资源集中在战略性领域，帮助客户取得成功，同时让开发者的工作更加轻松。虽然 GitHub Actions 仍然是这一愿景的关键组成部分，但我们正在将资源调配到 Actions 的其他领域，目前不接受对本仓库的贡献。GitHub 公共路线图是了解我们正在开发的功能及其进展阶段的最佳途径。

我们正在采取以下措施来更好地引导与 GitHub Actions 相关的请求，包括：

1. 我们将把问题和支持请求引导至 [社区讨论区](https://github.com/orgs/community/discussions/categories/actions)

2. 高优先级的 Bug 可以通过社区讨论区提交，也可以向我们的支持团队报告：https://support.github.com/contact/bug-report

3. 安全问题请按照我们的 [security.md](security.md) 进行处理

在此期间，我们仍将为本项目提供安全更新并修复重大破坏性变更。

欢迎你继续在此仓库中提交 Bug 报告。

### 目录结构

* [ci](ci)：持续集成工作流解决方案
* [deployments](deployments)：部署工作流解决方案
* [automation](automation)：自动化工作流解决方案
* [code-scanning](code-scanning)：[代码扫描](https://github.com/features/security) 解决方案
* [pages](pages)：Pages 工作流解决方案
* [icons](icons)：对应模板的 SVG 图标

每个工作流必须使用 YAML 编写，并以 `.yml` 为扩展名。还需要一个对应的 `.properties.json` 文件，包含该工作流的额外元数据（这些信息会显示在 GitHub.com 的界面中）。

例如：`ci/django.yml` 和 `ci/properties/django.properties.json`。

### 有效属性

* `name`：在引导界面中显示的名称。此属性在仓库中必须唯一。
* `description`：在引导界面中显示的描述
* `iconName`：对应文件夹中的图标名称，例如 `django` 应有一个图标 `icons/django.svg`。目前仅支持 SVG 格式。另一个选项是使用 [octicon](https://primer.style/octicons/)。使用 octicon 的格式为 `octicon <<icon name>>`。例如：`octicon person`
* `creator`：模板的创建者，显示在引导界面中。同一作者的所有工作流模板将使用相同的 `creator` 字段。
* `categories`：模板将显示在哪些分类下。请从[下方列表](#分类)中选择至少一个分类。此外，还可以从[此处](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml)的语言列表和[此处](https://github.com/github-starter-workflows/repo-analysis-partner/blob/main/tech_stacks.yml)的技术栈列表中选择分类。当用户浏览可用模板时，与所选语言和技术栈匹配的模板将获得更突出的展示。

### 分类
* continuous-integration
* deployment
* testing
* code-quality
* code-review
* dependency-management
* monitoring
* Automation
* utilities
* Pages
* Hugo

### 变量
以下变量可以放置在入门工作流中，将按照如下规则进行替换：

* `$default-branch`：将替换为仓库的分支名称，例如 `main` 和 `master`
* `$protected-branches`：将替换为仓库中任何受保护的分支
* `$cron-daily`：将替换为当天一个有效但随机的时间

## 如何在发布前测试模板

### 对公众隐藏模板
模板作者在模板的 `properties.json` 文件中添加一个 `labels` 数组，并加入 `preview` 标签。这样可以对普通用户隐藏该模板，除非用户在 URL 中使用查询参数 `preview=true`。
示例 `properties.json` 文件：
```json
{
    "name": "Node.js",
    "description": "Build and test a Node.js project with npm.",
    "iconName": "nodejs",
    "categories": ["Continuous integration", "JavaScript", "npm", "React", "Angular", "Vue"],
    "labels": ["preview"]
}
```

要查看带有 `preview` 标签的模板，请在 `新建工作流` 页面 URL 中添加查询参数 `preview=true`。例如：`https://github.com/<owner>/<repo_name>/actions/new?preview=true`。

### 公开发布模板
从 `properties.json` 文件中移除 `labels` 数组即可将模板公开发布。

#import "../index.typ": template, tufted
#import "../../_data/posts.typ": post-tags
#show: template.with(title: "我的学术写作工作流", lang: "zh", date: datetime(year: 2026, month: 10, day: 3), margin-citations: true)

= 我的学术写作工作流

#tufted.margin-note[#html.elem("span", attrs: (class: "lang-switch"))[*zh* / #link("/Blog/2026-10-03-academic-writing-workflow/en/")[en]]]

#post-tags("/Blog/2026-10-03-academic-writing-workflow/")

你只有被 Word 伤害过，才知道这是一个多么差的软件。我一直到写完#link("https://www.proquest.com/openview/611a2d36a9ab67fd5a83e9f51ba7029d/1?pq-origsite=gscholar&cbl=2026366&diss=y")[博士论文]之后才理解这一点。简单说几个问题：

+ *图一多，打开就是噩梦。* 如果你的文章里有很多高清图片，每一次打开，光渲染就要等很久。因为我的博士论文太长太卡，我会提前打开文件，一边等它渲染一边做自己的事，回来却发现 Word 报错，只能重新来过。
+ *对数学公式的兼容性是灾难性的。* 虽然可以用内嵌的功能按 LaTeX 语法输入公式，但这种渲染极其不稳定。有时候我只是动了一些无关紧要的地方，所有公式就一起失去了自动渲染。
+ *格式。* 我没那么多工夫去捣鼓，为什么我的一些文字莫名其妙被锁定了行距，怎么都调不了。

== Overleaf 和 LaTeX

一个自然的过渡是 Overleaf。但如果你没有多人在线同时协作的需求，它仍然是一个灾难性的产品：所有东西都在浏览器里，离线没法用；文章一长，编译就慢，免费版还会编译超时；文件和版本管理也远不如在本地顺手。

不过 Overleaf 让我意识到，我可以用 LaTeX 来写作，而且几乎所有期刊都支持 LaTeX 投稿。问题是 LaTeX 的学习体验实在太差，我也预期不到学会之后能对我有多大帮助，于是大概学了三天就放弃了。

== Quarto

最后是 Quarto#footnote[#link("https://quarto.org")[Quarto] 是 Posit（RStudio 的公司）做的开源写作和出版系统，同一份源文件可以输出 PDF、Word、HTML 和幻灯片。]，它相当好地满足了我的需要。而且因为 AI 越来越方便，只要你"意会"了这套工作流，配置上的事情都可以交给 AI，所以这里不赘述细节。

Quarto 的流程是把 `.qmd` 转成 Markdown，再转成 LaTeX，最后生成 PDF。你只需要会 Markdown 语法（我相信大多数人为了看懂 LLM 时不时抽风吐出来的乱码，已经对 Markdown 有了深厚的接触）。它是纯文本，不再有任何富文本#footnote[*富文本*（rich text）是指字体、行距、样式这些格式信息和文字一起存在文件里，但你看不到它们。Word 的 `.docx` 本质上是一包压缩过的 XML。]带来的使用摩擦：文件里写了什么就是什么。

=== 在文章里直接跑代码

`.qmd` 可以在 Markdown 里直接插入 R chunk，实现一些很有意思的功能。比如图可以在你的正文里现画，下面是 #link("https://quarto.org")[Quarto 官网]的例子#footnote[#image("fig-airquality.png") 上面这段代码渲染出来的图。]：

````markdown
---
title: "ggplot2 demo"
author: "Norah Jones"
date: "5/22/2021"
format:
  html:
    fig-width: 8
    fig-height: 4
    code-fold: true
---

## Air Quality

@fig-airquality further explores the impact of temperature on ozone level.

```{r}
#| label: fig-airquality
#| fig-cap: "Temperature and ozone level."
#| warning: false

library(ggplot2)
ggplot(airquality, aes(Temp, Ozone)) +
  geom_point() +
  geom_smooth(method = "loess")
```
````

不过我不建议这样做。我会把图和画图的代码分开管理，分别放在 `figure/` 和 `figure_script/` 里（见文末）。更有用的场景是在文章里直接放示例代码，例如我在这篇 tutorial paper 里做的 @zhang2026bayesian。

=== 引用

你不再需要担心 Zotero 之类的文献管理软件在 Word 里抽风。让它导出一个 `.bib` 文件，然后在正文里直接用 citekey 引用。上面那句话的源文件大概长这样：

```markdown
更有用的场景是在文章里直接放示例代码，
例如我在这篇 tutorial paper 里做的 [@zhang2026bayesian]。
```

=== 格式交给 AI

配合 AI 使用，调整格式的体验也非常好。我到现在都不知道 APA 对表格的具体要求是什么，但用 apaquarto#footnote[apaquarto 是 W. Joel Schneider 维护的 Quarto 扩展，专门按 APA 第 7 版排版：#link("https://github.com/wjschne/apaquarto")[github.com/wjschne/apaquarto]。Quarto 还有丰富的 extension，支持各种不同的引用风格和期刊模板。] 加上 `kable` 出表，LLM 会确保我不会因为格式被奇怪的 reviewer 挑刺。

另外，处理好的 `.qmd` 文件本身就是一个代码文件，或者说纯文本文件，所以 AI 读写起来非常原生。很多 AI 工具读 Word 和 PDF，其实是靠截图或者版面识别：如果你的观点正好写在一页的末尾，很可能被页眉页脚截断，AI 就没法很好地理解。

== 最小的 infra

我推荐用这样一个最小的结构来管理一篇文章：

```text
my-paper/
├── data/            # 原始数据和清理后的数据
├── script/          # 分析代码
├── figure_script/   # 画图的代码
├── figure/          # 生成的图
├── paper/           # .qmd 正文、.bib、期刊模板
├── model/           # （可选）缓存的模型 .rds，不用每次重跑
└── stan/            # （可选）手写的 Stan 模型
```

`model/` 和 `stan/` 是因为我有手搓 Stan 模型、缓存模型 `.rds` 的需要，不需要的话可以不建。

== 小结

从接触这套工作流开始，我再也没有打开过 Word#footnote[开玩笑的，和别人合作的项目没办法，还是得用。]。关键不是我用了什么工具（我相信有很多类似 Quarto 的选择，比如这个网站就是用 #link("https://typst.app")[Typst] 做的），而是我理解了如何更高效地管理一个项目的所有信息，避免不必要的 UX 摩擦。一旦学会了这些，相信你的 AI 也会变得更加聪明。

#[#set text(lang: "en"); #bibliography("refs.bib", style: "apa", title: "References")]

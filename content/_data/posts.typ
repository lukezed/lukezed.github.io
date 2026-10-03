#import "../../config.typ": tufted

// 所有文章的清单：Blog、Notes、Tags 页面和文章顶部的标签都从这里读
// 加新文章：在这里加一行，再写文章本身
#let posts = (
  (
    title: "My academic-writing workflow",
    path: "/Blog/2026-10-03-academic-writing-workflow/",
    date: datetime(year: 2026, month: 10, day: 3),
    section: "Blog",
    lang: "en",
    tags: ("workflow", "quarto", "writing"),
  ),
)

#let tag-link(t) = html.elem("a", attrs: (class: "tag", href: "/Tags/#" + t))[\##t]

// 文章顶部：显示这篇文章的标签
#let post-tags(path) = {
  let p = posts.find(p => p.path == path)
  if p != none { html.elem("p", attrs: (class: "post-tags"), p.tags.map(tag-link).join(" ")) }
}

// 列表页：按日期倒序列出符合条件的文章
#let post-list(filter) = {
  for p in posts.filter(filter).sorted(key: p => p.date).rev() {
    tufted.blog-entry(date: p.date, path: p.path, title: p.title)
  }
}

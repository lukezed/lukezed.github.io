#import "../index.typ": template, tufted
#import "../_data/posts.typ": post-list
#show: template.with(
  title: "Blog",
  description: "哲思和学术",
)

= 博客 / Blog

#tufted.margin-note[翻译自己写的东西太麻烦了，所以我只会提供 LLM 的直译版。]

== 中文

#post-list(p => p.section == "Blog" and p.lang == "zh")

== English

#post-list(p => p.section == "Blog" and p.lang == "en")

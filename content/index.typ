#import "../config.typ": template, tufted
#show: template

#tufted.margin-note[#image("imgs/nomi-7129.jpg") 糯米鸡在曼城]
#tufted.margin-note[#image("imgs/nomi-9126.jpg") 糯米鸡在回国]
#tufted.margin-note[#image("imgs/nomi-9173.jpg") 糯米鸡在上海]

= 你好，我是 Chi.

- “这是一本超现代电子书，偶尔翻到诗歌这一章。”

// 常见问题：每篇都来自 Blog 或 Notes
#let faq(title, href, meta) = html.elem("a", attrs: (class: "faq-item", href: href))[
  #html.elem("span", attrs: (class: "faq-q"))[#title]
  #html.elem("span", attrs: (class: "faq-meta"))[#meta]
]

#html.elem("section", attrs: (class: "faq-band"))[
  #html.elem("div", attrs: (class: "kicker"))[Frequently asked（根本没人在问）]
  #faq("我的学术写作工作流", "/Blog/2026-10-03-academic-writing-workflow/", "Blog · 2026-10-03")
]

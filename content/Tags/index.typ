#import "../index.typ": template, tufted
#import "../_data/posts.typ": posts, post-list
#show: template.with(title: "标签 Tags", description: "按标签浏览")

= 标签 / Tags

#for t in posts.map(p => p.tags).flatten().dedup().sorted() [
  #html.elem("h3", attrs: (id: t))[\##t]
  #post-list(p => t in p.tags)
]

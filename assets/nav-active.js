// 导航栏高亮当前栏目：/Blog/xxx/ 也算 Blog，主页只在 / 时高亮
document.addEventListener("DOMContentLoaded", () => {
	const path = location.pathname;
	for (const a of document.querySelectorAll(".site-nav a")) {
		const href = a.getAttribute("href");
		if (href === "/" ? path === "/" || path === "/index.html" : path.startsWith(href)) a.classList.add("is-active");
	}
});

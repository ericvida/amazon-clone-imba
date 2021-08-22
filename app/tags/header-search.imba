tag header-search
	css input
		h:9tw w:30tw flg:1
		px:3 ml:6tw rdl:xl 
		bg:cooler8 bd:cooler5/25 c:white outline@focus:none
		@placeholder 
			c:white
	css .categories
		h:9tw w:30tw pl:3tw
		bg:cooler8 bd:gray5/25  c:white d:flex ai:center
		svg h:4tw w:4tw ml:2tw
	css .search-icon
		h:9tw w:10tw bg:yellow5 rdr:xl d:flex jc:center ai:center c:white
		svg h:6tw w:6tw
	def render
		<self[d:flex]>
			<input type="text" placeholder="Search...">
			<div.categories>
				"categories"
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
			<div.search-icon>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
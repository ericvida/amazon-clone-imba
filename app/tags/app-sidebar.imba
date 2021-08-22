tag app-sidebar < div
	css .app-sidebar 
		w:20% d:flex p:6tw
		bg:cooler9 bdt:5tw bd:cooler7
		# visibility: hidden
		@md d:block
	css .sidebar-main-category
			d:flex  p:2tw ai:center
			cursor:pointer fw:bold
			rd:lg
			fw:bold
			c:yellow5
			@hover bg:cooler7
			@active bg:cooler7
			.icon
				d:flex jc:center ai:center
				w:8tw
				svg
					w:6tw h:6tw
			&.active
				bg:cooler7
	css .sidebar-category
			d:flex  p:2tw ai:center
			cursor:pointer fw:bold
			rd:lg
			fw:bold
			c:cooler2
			@hover bg:cooler7
			@active bg:cooler7
			.icon
				w:8tw
				d:flex jc:center ai:center
				svg.percent
					w:4tw
				svg.question
					w:5tw
	def render
		<self.app-sidebar> 
			<div.sidebar-categories>
				<div.sidebar-main-category.active>
					<span.icon>
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
					<span> "Categories"
				<div.sidebar-category>
					<span.icon>
					<span> "Echo and Alexa"
				<div.sidebar-category>
					<span.icon>
					<span> "Kindle"
				<div.sidebar-category>
					<span.icon>
					<span> "Books"
				<div.sidebar-category>
					<span.icon>
					<span> "Electronics"
				<div.sidebar-category>
					<span.icon>
					<span> "Home & Garden"
				<div.sidebar-category>
					<span.icon>
					<span> "Fashion"
				<div.sidebar-category>
					<span.icon>
						<svg[fill:white].percent xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
							<path d="M112 224c61.9 0 112-50.1 112-112S173.9 0 112 0 0 50.1 0 112s50.1 112 112 112zm0-160c26.5 0 48 21.5 48 48s-21.5 48-48 48-48-21.5-48-48 21.5-48 48-48zm224 224c-61.9 0-112 50.1-112 112s50.1 112 112 112 112-50.1 112-112-50.1-112-112-112zm0 160c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zM392.3.2l31.6-.1c19.4-.1 30.9 21.8 19.7 37.8L77.4 501.6a23.95 23.95 0 0 1-19.6 10.2l-33.4.1c-19.5 0-30.9-21.9-19.7-37.8l368-463.7C377.2 4 384.5.2 392.3.2z">
					<span> "Sell on Amazon"
				<div.sidebar-category>
					<span.icon>
						<svg[fill:white].question xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
							<path d="M256 8C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm0 448c-110.532 0-200-89.431-200-200 0-110.495 89.472-200 200-200 110.491 0 200 89.471 200 200 0 110.53-89.431 200-200 200zm107.244-255.2c0 67.052-72.421 68.084-72.421 92.863V300c0 6.627-5.373 12-12 12h-45.647c-6.627 0-12-5.373-12-12v-8.659c0-35.745 27.1-50.034 47.579-61.516 17.561-9.845 28.324-16.541 28.324-29.579 0-17.246-21.999-28.693-39.784-28.693-23.189 0-33.894 10.977-48.942 29.969-4.057 5.12-11.46 6.071-16.666 2.124l-27.824-21.098c-5.107-3.872-6.251-11.066-2.644-16.363C184.846 131.491 214.94 112 261.794 112c49.071 0 101.45 38.304 101.45 88.8zM298 368c0 23.159-18.841 42-42 42s-42-18.841-42-42 18.841-42 42-42 42 18.841 42 42z">
					<span> "Help"

### TODO:
###
tag cart-icon
	css .cart-item
		h:10tw px:1rem rd:xl
		d:flex ai:center jc:center pos: relative 
		bg:yellow5  @hover:yellow4 @active: yellow5 cursor:pointer
		svg size:1.5rem c:gray6 
		div fs:1rem px:0.4rem c:rose9
	def render
		<self>
			<a route-to="/cart">
				<div.cart-item>
					<svg xmlns="http://owww.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path[stroke:rose9] stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
					<div[td:none text]> state.data.cart-count
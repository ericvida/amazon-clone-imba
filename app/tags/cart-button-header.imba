tag cart-button
	css .cart-item
		h:10tw w:10tw pos: relative
		d:flex ai:center jc:center
		bg:yellow5  rd:xl
		svg h:4tw w:4tw c:gray6
	css .cart-item-number 
		h:4tw w:4tw t:-1tw r:-1tw
		d:flex jc:center ai:center pos: absolute
		bg:white rd:full c:gray8 fs:xs


	def render
		<self>
			<a route-to="/cart">
				<div.cart-item>
					<div.cart-item-number> 
						state.cartCount
					<svg xmlns="http://owww.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
import './cart-button-purchase'
tag app-cart
	css self
		d:flex p:6tw bg:cooler1 fld:column fl:1
	css h1 fw:bold c:cooler4 fs:3xl mb:6tw
	css .table-titles c:cooler4 fw:bold d:flex
		.product flg:1
		.units fls:1 w:48tw
		.total fls:1 w:48tw
		.delete fls:1 w:10tw
	css .cart-items mt:5tw
	css .cart-item d:flex bg:white bdb:medium solid cooler1
		.image w:40tw h:40tw bg:white p:4tw of:hidden p:6tw us:none
		.details px:4tw d:flex fld:column jc:center flg:1 us:none
			.title fw:bold fs:sm c:cooler6
			.brand fs:sm c:cooler4
		.counter w:48tw d:flex ai:center c:cooler5 w:48tw
			button	
				cursor:pointer 
				c:cooler4
				bg:cooler1 @hover:gray2
				rd:md h:6tw	w:6tw 
				d:flex jc:center ai:center
				us:none
			svg h:3tw fill:cooler5
			.number px:4tw
			# .less
			# .more
		.total-cost w:48tw d:flex ai:center fw:bold c:cooler5
		.delete w:10tw d:flex ai:center 
			svg fill:cooler3 @hover:red4

	def render
		<self>
			<h1> "Shopping Cart"
			<.table-titles>
				<h2.product> "Product"
				<h2.units> "Quantity"
				<h2.total> "Total Cost"
				<h2.delete>
			<.cart-items>
				for item,i in state.cartItems
					<div.cart-item>
						<.image>
							<img src=item.image>
						<.details>
							<.title> item.name
							<.brand> item.make
						<.counter>
							<button.less @click=state.decreaseQty(item)>
								<svg.chevron-left xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"/>
							<h4.number> item.quantity # FIXME: This number doesn't update properly
							<button.more @click=state.increaseQty(item)>
								<svg.chevron-right xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"/>
						<.total-cost>
							<span> "${state.toDollars(item.price * item.quantity)}"
						<.delete @click=state.deleteCartItem(item, i)>
							<div.clickable>
								<svg[w:4tw].times xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"><path d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"/>
				<button-complete-purchase>

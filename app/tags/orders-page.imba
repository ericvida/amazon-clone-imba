export tag orders-page < page
	prop orderCount = 0
	css ul
		rd:1rem of:hidden shadow:xs,lg
		li 
			bg:white px:1.5rem ff:mono py:2rem 
			bdb:medium solid cooler1 @last: none
			d:flex jc:space-between 
	def removeOrder id
		# console.log id
		state.deleteOrder(id)
	def render
		<self>
			<h1> "Orders {state.data.order-count}"
			<ul role="list">
				for own id, order of state.data.order-items
					<li>
						<h2> "{order.date}"
						<h2> order.totalCost
						<h2> "{order.totalQuantity} items"
						<div @click=removeOrder(id)>
							<svg[w:4tw fill:cooler3 @hover:rose7 cursor:pointer].times xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"><path d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"/>
						# TODO: STYLE THIS DATA
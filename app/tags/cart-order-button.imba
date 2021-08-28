tag cart-order-button
	def completeOrder
		state.completeOrder!
	def totalCost
		state.toDollars(state.getCartTotalCost!)
	def render
		<self>
			<div.complete-order>
				css d:flex jc:flex-end mt:10tw mr:7 w:full
				<div.total-cost>
					css c:cooler4 mr:7tw
					<h2> "Total Cost"
					<div.total-cost-number>
						css c:cooler6 fs:3xl
						"${totalCost!}"
				<div.complete-order-button @click=completeOrder> "Complete Order"
					css w:56tw d:flex ai:center jc:center bg:yellow5 @hover:amber5 c:white cursor:pointer rd:md
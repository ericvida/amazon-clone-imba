tag cart-order-button
	def completeOrder
		let today = new Date()
		let dateString = 'Y-m-d'
			.replace('Y', today.getFullYear())
			.replace('m', today.getMonth()+1)
			.replace('d', today.getDate())
		let order = {
			items: state.data.cart-items
			totalCost: state.getCartTotalCost!
			totalQuantity: state.data.cart-count
			date: dateString
			}
		state.completeOrder(order)
		console.log 'an order was completed'
		# state.firestoreSetOrder(order)
	def render
		<self>
			<div.complete-order>
				css d:flex jc:flex-end mt:10tw mr:7 w:full
				<div.total-cost>
					css c:cooler4 mr:7tw
					<h2> "Total Cost"
					<div.total-cost-number @click=completeOrder> "{state.getCartTotalCost!}"
						css c:cooler6 fs:3xl
				<div.complete-order-button @click=completeOrder> "Complete Order"
					css w:56tw d:flex ai:center jc:center bg:yellow5 @hover:amber5 c:white cursor:pointer rd:md
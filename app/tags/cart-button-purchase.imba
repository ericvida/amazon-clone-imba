import state from '../state'
tag button-complete-purchase
	# def mount
	# 	console.log state.cartItems
	def getTotalCost items
		let totalCost = 0
		for item in items
			totalCost += (item.price * item.quantity)
		return totalCost
	def toDollars num
		Number(parseFloat(num).toFixed(2)).toLocaleString!
			'en'
			{minimumFractionDigits: 2}
	def render
		<self>
			<div.complete-order>
				css d:flex jc:flex-end mt:10tw mr:7 w:full
				<div.total-cost>
					css c:cooler4 mr:7tw
					<h2> "Total Cost"
					<div.total-cost-number> "{toDollars(getTotalCost(state.cartItems))}"
						css c:cooler6 fs:3xl
				<div.complete-order-button> "Complete Order"
					css w:56tw d:flex ai:center jc:center bg:yellow5 @hover:amber5 c:white cursor:pointer rd:md
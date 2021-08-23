import state from '../state'
tag button-complete-purchase
	def render
		<self>
			<div.complete-order>
				css d:flex jc:flex-end mt:10tw mr:7 w:full
				<div.total-cost>
					css c:cooler4 mr:7tw
					<h2> "Total Cost"
					<div.total-cost-number> "{state.getCartTotalCost!}"
						css c:cooler6 fs:3xl
				<div.complete-order-button> "Complete Order"
					css w:56tw d:flex ai:center jc:center bg:yellow5 @hover:amber5 c:white cursor:pointer rd:md
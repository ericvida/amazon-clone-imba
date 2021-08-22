let state = {}
state.fb-products = []
state.products = []
state.cartItems = []
state.cartCount = 0
state.cartCost = 0
extend tag Element
	get state
		return state
export default state
# import ls from './LocalStorage.imba'
# import fs from './firestore.imba'
import './styles'
import state from './state.imba'
import './tags/app-header'
import './tags/home-page'
import './tags/cart-page'
import './tags/orders-page'
import './tags/cart-icon'
import './tags/page'
tag shopping-app
	css self d:block w:100% bg:cooler1 min-height:100vh
	def setup
		# state.clear!
		state.firestoreInitialize!
		# state.setAllItems(state.data)
		# state.getAllItems(state.data)
	def render
		<self> 
			<app-header>
			<main>
				<home-page route="/home">
				<cart-page route="/cart">
				<orders-page route="/orders">

imba.mount <shopping-app>

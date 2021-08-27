import firebase from 'firebase/app'
import firebaseConfig from './firebase_config.imba'
# import lf from 'localforage'
# import {local} from '@toolz/local-storage'
# import {areEqual} from '@composi/are-equal'
firebase.initializeApp(firebaseConfig)
class State
	prop data = {
		product-items: {}
		cart-items: {}
		orders: {}
		order-count: 0
		cart-count: 0
		cart-cost: 0
	}
	def constructor
		db = firebase.firestore()
	# =======================================================
	# SECTION: 🕹 USER STATE
	# =======================================================
	# NOTE: Adds poduct to cart in user state
	def addToCart id, product-item
		let cartItem = data.cart-items[id]
		let cartItemExists = data.cart-items.hasOwnProperty(id)
		if cartItemExists
			if cartItem.quantity > 0
				incCartItemQuantity(id, cartItem)
				console.log "increased quantity in cart:", product-item.name
				imba.commit!
		else
			data.cart-items[id] = product-item
			data.cart-items[id].quantity = 1
			firestoreAddToCart(id, product-item)
			# console.log "added to cart:", product.name
			imba.commit!
	# =======================================================
	# NOTE: removes item from cart in user state
	def deleteCartItem id
		delete data.cart-items[id]
		db.collection("cart-items").doc(id).delete!
		imba.commit!
	# =======================================================
	# NOTE: removes item from Order in user state
	def deleteOrder id
		delete data.orders[id]
		db.collection("orders").doc(id).delete!
		dimOrderCount!
		imba.commit!
	# NOTE: Get's total cost of Cart>
	def getCartTotalCost
		let totalCost = 0
		for own id, item of data.cart-items 
			totalCost += (item.price * item.quantity)
		return "$" + toDollars(totalCost)
	# =======================================================
	def cartHasProduct product
		let cart = data.cart-items
		if cart.hasOwnProperty[product.id]
			return yes
		else
			return no
		imba.commit!
	# =======================================================
	# NOTE: Decreases Item Quantity in user state
	def dimCartItemQuantity id, item
		# let item_index = data.cart-items.indexOf(id, item)
		let quantity = data.cart-items[id].quantity
		if quantity > 1
			quantity = --data.cart-items[id].quantity
			console.log "decreased ({item.name}) quantity to {quantity} in cart"
			dimCartCount!
			firestoreDimCartItemQuantity(id, item.quantity) # 🔥 firestore
		# elif quantity is 1
		# 	deleteCartItem(id)
		imba.commit!
	# =======================================================
	# NOTE: Increases Item Quantity in user state
	def incCartItemQuantity id, item
		# update local storage
		# let item_index = data.cart-items.indexOf(item)
		let increased_counter = data.cart-items[id].quantity
		if increased_counter > 0
			data.cart-items[id].quantity++
			console.log "increased ({item.name}) quantity to {} in cart"
			incCartCount!
			firestoreIncCartItemQuantity(id, item.quantity) # 🔥 firestore
		else
			console.log "item reached zero", data.cart-items
		# update firestore
		imba.commit!
	# =======================================================
	# NOTE: increase Order Total Quantity
	def incOrderCount
		data.order-count++
	# =======================================================
	# NOTE: decrease Order Total Quantity
	def dimOrderCount
		data.order-count--
	# =======================================================
	# NOTE: Increases Cart Total Quantity
	def incCartCount
		data.cart-count++
	# =======================================================
	# NOTE: Decreases Cart Total Quantity
	def dimCartCount
		data.cart-count--
	def clearCart
		data.cart-count = 0
		data.cart-items = {}
		firestoreClearCart!
		imba.commit!
	# =======================================================
	# NOTE: Add order to user state
	def completeOrder order
		incOrderCount!
		firestoreSetOrder(order)
		clearCart!
		firestoreGetOrders!
		imba.commit!
	# =======================================================
	# SECTION: 📦 LOCAL STORAGE
	# =======================================================
	# def clear
	# 	local.clear!
	# DOES: sets all items to local store
	# def setAllItems store
	# 	for own key, val of store
	# 		setItem(key,val)
	# DOES: gets all items from local store
	# def getAllItems store
	# 	for own key, val of store
	# 		store[key] = local.getItem(key)
	# DOES: gets items from local store
	# def getItem key
	# 	let res = local.getItem(key)
	# 	data[key] = res
	# 	# console.log 'got:', res
	# 	return res
	# DOES: adds item to local store
	# def setItem key, value
	# 	# console.log 'set:', value
	# 	data[key] = value
	# 	local.setItem(key, value)

	# =======================================================
	# SECTION:🔥 FIRESTORE
	# =======================================================
	# NOTE: 🔥 Gets all products and shopping cart data from firestore
	# and updates the state
	def firestoreInitialize
		firestoreGetProducts!
		firestoreGetCart!
		firestoreGetOrders!
		imba.commit!
	# =======================================================
	# NOTE: 🔥 Gets all Products from firestore
	def firestoreGetProducts
		db.collection("products").get!.then! do(querySnapshot)
			let products = {}
			querySnapshot.forEach! do(item)
				products[item.id] =
					image: item.data!.image
					name: item.data!.name
					make: item.data!.make
					price: item.data!.price
					rating: item.data!.rating
			# setItem('products', products)
			data.product-items = products
			imba.commit!
	# =======================================================
	# NOTE: 🔥 Gets all Cart Data from firestore
	def firestoreGetCart
		db.collection('cart-items').onSnapshot! do(snapshot)
			let firestoreCartCount = 0
			let firestoreCartItems = {}
			snapshot.docs.forEach! do(doc)
				let id = doc.id
				let item = doc.data!
				firestoreCartCount += item.quantity
				firestoreCartItems[id] =
					image: item.image
					make: item.make
					name: item.name
					price: item.price
					quantity: item.quantity
					rating: item.rating
					id: doc.id
				data.cart-items = firestoreCartItems
				if data.cart-count isnt firestoreCartCount
					data.cart-count = firestoreCartCount
				imba.commit!
	# =======================================================
	# NOTE: 🔥 Gets all Orders from firestore to user state
	def firestoreGetOrders
		db.collection('orders').onSnapshot! do(snapshot)
			let res = {}
			let count = 0
			snapshot.docs.forEach! do(doc)
				count++
				res[doc.id] = doc.data!
				imba.commit!
			data.order-count = count
			data.orders = res
	# =======================================================
	# NOTE: 🔥 Adds Product to Cart in firestore
	def firestoreAddToCart id, product
		let cartItem = db.collection("cart-items").doc(id)
		cartItem.get().then! do(item)
			if !item.exists
				cartItem.set!
					image: product.image
					make: product.make
					name: product.name
					price: product.price
					rating: product.rating
					quantity: 1
				console.log 'added item to firestoreCart'
				imba.commit!
	# =======================================================
	# NOTE: 🔥 Clear Cart in firestore
	# db.collection("cart-items").doc(id).delete!
	def firestoreClearCart
		db.collection('cart-items').onSnapshot! do(snapshot)
			snapshot.docs.forEach! do(doc)
				# console.log doc.id
				doc.ref.delete!
				imba.commit!
	# =======================================================
	# NOTE: 🔥 Increase quantity of item in firestore
	def firestoreIncCartItemQuantity id, quantity
		let cartItem = db.collection("cart-items").doc(id)
		cartItem.get().then! do(item)
			if item.exists
				cartItem.update!
					quantity: quantity++
				console.log "increased firestore item quantity to {quantity - 1}"
				imba.commit!
	# =======================================================
	# NOTE: 🔥 Decrease quantity of item in firestore
	def firestoreDimCartItemQuantity id, quantity
		# update firestore
		let firestoreCartItem = db.collection("cart-items").doc(id)
		let item = await firestoreCartItem.get()
		if item.exists
			let item_data = item.data!
			if item_data.quantity > 1
				firestoreCartItem.update!
					quantity: quantity--
				imba.commit!
				console.log "decreased firestore item quantity to {quantity - 1}"
	# =======================================================
	# NOTE: 🔥 Add order
	def firestoreSetOrder order
		let orders = db.collection("orders").doc()
		orders.get().then! do(item)
			if !item.exists
				orders.set!
					order
				imba.commit!
	# =======================================================
	# NOTE: 🔥 get orders
	# =======================================================
	# SECTION: 🔧 UTILITY FUNCTIONS
	# =======================================================
	# NOTE: adds commas to money
	def toDollars num
		Number(parseFloat(num).toFixed(2)).toLocaleString('en',{minimumFractionDigits: 2})
# =======================================================
# SECTION: EXPORT STATE
# =======================================================
let state = new State
extend tag Element
	get state
		return state
export default state
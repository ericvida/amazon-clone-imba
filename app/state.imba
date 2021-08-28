import firebase from 'firebase/app'
import firebaseConfig from './firebase_config.imba'
# import lf from 'localforage'
# import {local} from '@toolz/local-storage'
# import {areEqual} from '@composi/are-equal'
firebase.initializeApp(firebaseConfig)
class State
	prop data = {
		product-items: {}
		product-count: 0
		cart-items: {}
		cart-count: 0
		cart-total: 0
		orders: {}
		order-count: 0
	}
	def constructor
		db = firebase.firestore()
	# =======================================================
	# SECTION: Product To Cart
	# =======================================================
	# NOTE: Adds poduct to cart in user state
	def addToCart id, newCartItem
		let duplicateCartItem = data.cart-items[id] # 🕹 cart item that is being added to cart
		let cartItemExists = data.cart-items.hasOwnProperty(id)
		switch cartItemExists
			when true # 🕹 if item is found in user state shopping cart
				# 1. 🕹 increase uses state cart counter + 1
				data.cart-count++
				# 2. 🕹 increase user state duplicate cart item quantity + 1 in
				duplicateCartItem.quantity++
				# 3. 🔥 update firestore cart item quantity + 1
				let fsDuplicateCartItem = db.collection("cart-items").doc(id) 
				fsDuplicateCartItem.get().then! do(item)
					if item.exists
						fsDuplicateCartItem.update!
							quantity: duplicateCartItem.quantity
						# console.log "increased firestore item quantity", duplicateCartItem.quantity
						imba.commit!
			when false # 🕹 if item is not found user state shopping cart
				# 1. 🕹 increase user state cart-count
				data.cart-count++
				# 2. 🕹 add quantity of 1 to newCartItem
				newCartItem.quantity = 1
				# 2. 🕹 add newCartItem to user state and set to variable
				let addingToCart = data.cart-items[newCartItem.id] = newCartItem
				# 3. 🔥 update firestore with addingToCart item
				let fsCartItem = db.collection("cart-items").doc(id)
				fsCartItem.get().then! do(item)
					if !item.exists
						fsCartItem.set! addingToCart
						# console.log 'added item to firestoreCart'
						imba.commit!
	# =======================================================
	# SECTION: CART PAGE
	# =======================================================
	# NOTE: Decreases Item Quantity in user state
	def dimCartItemQuantity cartItem
		let id = cartItem.id
		if cartItem.quantity > 1
			# 1. 🕹 decrease cart count on user state
			data.cart-count--
			# 2. 🕹 decrease cartItem.quantity on user state
			cartItem.quantity--
			# 3. 🕹 update cart totalCost
			data.cart-total = getCartTotalCost!
			# 4. 🔥 decrease cartItem.quantity on firestore
			let fsCartItem = db.collection("cart-items").doc(id)
			let item = await fsCartItem.get()
			if item.exists
				fsCartItem.update!
					quantity: cartItem.quantity
				console.log "decreased firestore item quantity to {cartItem.quantity}"
	# =======================================================
	# NOTE: Increases Item Quantity in user state
	def incCartItemQuantity cartItem
		let id = cartItem.id
		if cartItem.quantity > 0
			# 1. 🕹 increase cart count in user state
			data.cart-count++
			# 2. 🕹 increase cartItem.quantity in user state
			cartItem.quantity++
			# 3. 🕹 update cart totalCost
			data.cart-total = getCartTotalCost!
			# 4. 🔥 add cartItem to cart in firestore 
			let fsCartItem = db.collection("cart-items").doc(id)
			let item = await fsCartItem.get()
			if item.exists
				fsCartItem.update!
					quantity: cartItem.quantity
				console.log "increased firestore item quantity to {cartItem.quantity}"
	# =======================================================
	# NOTE: removes item from cart in user state
	def deleteCartItem id
		let cartItem = data.cart-items[id]
		# 1. 🕹 Remove quantity from cart-count in user state
		data.cart-count -= data.cart-items[id].quantity
		# 2. 🕹 Remove product from cart in user state
		delete data.cart-items[id]
		# 3. 🕹 update totalCost
		data.cart-total -= (cartItem.quantity * cartItem.price)
		# 3. 🔥 Remove product from cart in firestore
		db.collection("cart-items").doc(id).delete!
	
	# =======================================================
	# NOTE: 🕹 Get's total cost of Cart
	def getCartTotalCost
		let totalCost = 0
		for own id, item of data.cart-items 
			totalCost += (item.price * item.quantity)
		return totalCost
	# =======================================================
	# NOTE: removes item from Order in user state
	def deleteOrder id
		# 1. 🕹 diminish order count in user state
		data.order-count--
		# 2. 🕹 remove order from user state
		delete data.order-items[id]
		# 3. 🔥 remove order from firestore
		db.collection("orders").doc(id).delete!
	# =======================================================
	# NOTE: Add order to user state
	def completeOrder
		# 1. 🕹 increase order count
		data.order-count++
		# 2. 🕹 add date to Cart Object
		let timeStamp = new Date().valueOf()
		let today = new Date()
		let newDocID = db.collection("orders").doc().id
		let dateString = 'Y-m-d'
			.replace('Y', today.getFullYear())
			.replace('m', today.getMonth()+1)
			.replace('d', today.getDate())
		let cart = {
			id: "{newDocID}"
			items: data.cart-items
			totalCost: getCartTotalCost!
			totalQuantity: data.cart-count
			date: "{dateString}"
			}
		data.order-items[cart.id] = cart
		# 3. 🕹 empty cart in user state
		data.cart-items = {}
		# 4. 🕹 set cart count to zero in user state
		data.cart-count = 0
		# 4. 🔥 Add cart to orders in firestore
		let firestoreOrderItem = db.collection("orders").doc(cart.id) 
		firestoreOrderItem.set! data.order-items[cart.id]
		# 5. 🔥 Empty cart in firestore
		# FIXME: when complete order buton is pushed, it leaves one item in the cart when this function is run
		db.collection("cart-items").get().then! do(qSnapshot)
			qSnapshot.docs.forEach! do(snap)
				snap.ref.delete!
				imba.commit!
	# =======================================================
	# SECTION:🔥 FIRESTORE
	# =======================================================
	# NOTE: 🔥 Gets all products and shopping cart data from firestore
	# and updates the state
	def firestoreInitialize
		firestoreGetProducts!
		firestoreGetCart!
		firestoreGetOrders!
	# =======================================================
	# NOTE: 🔥 Gets all Products from firestore
	def firestoreGetProducts
		db.collection("products").get!.then! do(querySnapshot)
			let products = {}
			querySnapshot.forEach! do(item)
				products[item.id] =
					id: item.id
					image: item.data!.image
					name: item.data!.name
					make: item.data!.make
					price: item.data!.price
					rating: item.data!.rating
			# setItem('products', products)
			data.product-items = products
			for own item of data.product-items
				data.product-count++
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
			data.order-items = res
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
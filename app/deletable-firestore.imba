import firebase from 'firebase/app'
import firebaseConfig from './firebase_config.imba'
firebase.initializeApp(firebaseConfig)
class fireStore
	fb-products = []
	products = []
	cartItems = []
	cartCount = 0
	cartCost = 0
	db = {}
	def constructor
		db = firebase.firestore()
		getCartCount!
	def getCartCount
		db.collection("cart-items").onSnapshot! do(snapshot)
			cartCount = 0
			cartItems = []
			snapshot.docs.forEach! do(doc)
				let item = doc.data!
				cartCount += item.quantity
				cartItems.push({
					image: item.image
					make: item.make
					name: item.name
					price: item.price
					quantity: item.quantity
					rating: item.rating
					id: doc.id
				})
			# console.log 'cartItems', cartItems
			imba.commit!
	def decreaseQty item
		let cartItem = db.collection("cart-items").doc(item.id)
		let doc = await cartItem.get()
		if doc.exists
			let docdata = doc.data!
			if docdata.quantity > 1
				cartItem.update!
					quantity: docdata.quantity - 1
				item.quantity -= docdata.quantity - 1
				const item_index = cartItems.indexOf(item)
				cartItems[item_index] -= 1
		console.log "decrease to {item.quantity}"
		imba.commit!
	def increaseQty item
		let cartItem = db.collection("cart-items").doc(item.id)
		let doc = await cartItem.get()
		if doc.exists
			let docdata = doc.data!
			if docdata.quantity > 0
			cartItem.update(quantity: docdata.quantity + 1)
			item.quantity -= docdata.quantity + 1
			const item_index = cartItems.indexOf(item)
			cartItems[item_index] += 1
		console.log "increase to {item.quantity}"
		imba.commit!
	def deleteCartItem item, i
		db.collection("cart-items").doc(item.id).delete!
		cartItems.splice(i, 1)
		imba.commit!
	# def toDollars num
	# 	Number(parseFloat(num).toFixed(2)).toLocaleString('en',{minimumFractionDigits: 2})
	def getCartTotalCost
		let totalCost = 0
		for item in cartItems
			totalCost += (item.price * item.quantity)
		return "$" + toDollars(totalCost)
	def getProducts
		console.log getProducts!
		db.collection("products").get!.then! do(querySnapshot)
			let products = []
			querySnapshot.forEach! do(doc)
				products.push!
					id: doc.id
					image: doc.data!.image
					name: doc.data!.name
					make: doc.data!.make
					price: doc.data!.price
					rating: doc.data!.rating
			# state.products = products
			# console.log 'got products', state.products
			return products
			imba.commit!
let fs = new fireStore()
extend tag Element
	get fs
		return fs
export default fs
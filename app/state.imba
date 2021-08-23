import firebase from 'firebase/app'
import firebaseConfig from './api.imba'

firebase.initializeApp(firebaseConfig)


class State
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
			console.log 'cartItems', cartItems
			imba.commit!

	def toDollars num
		Number(parseFloat(num).toFixed(2)).toLocaleString('en',{minimumFractionDigits: 2})

let state = new State()


extend tag Element
	get state
		return state
export default state
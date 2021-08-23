# import '@fortawesome/fontawesome-free/js/all.js'
# import db from './api'	
import state from './state' 
# import './apis/firebase'
import 'imba/preflight.css'
import './styles.imba'
import './tags/app-header'
import './tags/app-sidebar'
import './tags/app-home'
import './tags/cart-page'
tag app
	css .main min-height:100vh d:flex
	def render
		<self>
			<app-header>
			<div.main>
				# <app-sidebar>
				<app-home route='/home'>
				<app-cart route='/cart'>
				
imba.mount <app>
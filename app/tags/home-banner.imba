tag home-banner < div
	css .home-banner
		min-height:60tw
		d:flex ai:flex-end
		bg:amber4 rd:xl shadow:xs
		bg:url("https://images-na.ssl-images-amazon.com/images/G/01/kindle/journeys/ZDNhNDdkYjQt/ZDNhNDdkYjQt-YzQ5MjIwOTEt-w1500._CB645809730_.jpg")
		bgp:top bgs:inherit
		.button
			bg:white
			# outline:none
			min-width:36tw
			min-height:10tw
			m:4tw px:5tw
			rd:full
			c:amber4 fw:bold
			d:flex jc:center ai:center
			cursor:pointer
		h4 fw:bold text-yellow:500tw 
	def render
		<self.home-banner>
			<.button>
				<span> "Browse Products"
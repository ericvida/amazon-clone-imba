export tag app-header < header
	def render
		<self>
			<nav>
				css d:flex jc:space-between w:100% bg:rose9
				<.left>
					css flg:1
					<.logo>
						css p:2rem cursor:pointer d:flex w:100%
						<span>
							css as:center pb:.2rem
							<svg[h:2rem] id="logo-38" viewBox="0 0 78 32" xmlns="http://www.w3.org/2000/svg">
								<path[fill:rose6] d="M55.5 0H77.5L58.5 32H36.5L55.5 0Z" .ccustom>
								<path[fill:rose5] d="M35.5 0H51.5L32.5 32H16.5L35.5 0Z" .ccompli1>
								<path[fill:rose4] d="M19.5 0H31.5L12.5 32H0.5L19.5 0Z" .ccompli2>
						<span> "AMAZUN"
							css
								c:rose1
								as:center
								line-height:2rem
								fs:2.6em
								ff:sans-serif
								font-style:italic
								fw:bold
				<.right>
					css d:flex flg:1 jc:space-evenly ai:center
						a c:white fw:bold fs:1.5rem td:none c:rose1 @hover:rose3 @active:amber3
					<a route-to="/home"> "{state.data.product-count} products"
					<cart-icon route-to="/cart">
					<a route-to="/orders"> "{state.data.order-count} orders"
			# <header-search>
			# <header-right-icons>

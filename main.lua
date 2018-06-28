
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")

--botoes
botaoUP = display.newRect(display.actualContentWidth/3.1,display.actualContentHeight/1.4,display.actualContentWidth/6,display.actualContentHeight/10)
botaoUP:setFillColor( 0.35 )
nomeBotaoUP = display.newText("UP",display.actualContentWidth/3.1,display.actualContentHeight/1.4,native.systemFont,13)

botaoDOWN = display.newRect(display.actualContentWidth/3.1,display.actualContentHeight/1.15,display.actualContentWidth/6,display.actualContentHeight/10)
botaoDOWN:setFillColor( 0.35 )
nomeBotaoUP = display.newText("DOWN",display.actualContentWidth/3.1,display.actualContentHeight/1.15,native.systemFont,13)

botaoLEFT = display.newRect(display.actualContentWidth/7,display.actualContentHeight/1.26,display.actualContentWidth/6,display.actualContentHeight/10)
botaoLEFT:setFillColor( 0.35 )
nomeBotaoLEFT = display.newText("LEFT",display.actualContentWidth/7,display.actualContentHeight/1.26,native.systemFont,13)

botaoRIGHT = display.newRect(display.actualContentWidth/1.98,display.actualContentHeight/1.26,display.actualContentWidth/6,display.actualContentHeight/10)
botaoRIGHT:setFillColor( 0.35 )
nomeBotaoRIGHT = display.newText("RIGHT",display.actualContentWidth/1.98,display.actualContentHeight/1.26,native.systemFont,13)

botaoSHOT = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/1.25,display.actualContentWidth/6,display.actualContentHeight/10)
botaoSHOT:setFillColor( 0.35 )
nomeBotaoUP = display.newText("SHOT",display.actualContentWidth/1.2,display.actualContentHeight/1.25,native.systemFont,13)
--botoes

cenario = display.newRect(display.actualContentWidth/2.05,display.actualContentHeight/3,display.actualContentWidth/1.1,display.actualContentHeight/1.85)
cenario.strokeWidth = 1
cenario:setFillColor(0)
cenario:setStrokeColor(1,1,1)
 
nave = display.newRect(display.actualContentWidth/6, display.actualContentHeight/3,10,10)
nave.strokeWidth = 3
nave:setFillColor( 0.1 )
nave:setStrokeColor( 1, 0, 0 ) 
physics.addBody(nave, "static")

tiro = {}

function moverNaveUP(event)
	
	if event.phase == "began" then
		if nave ~= nil then
			if nave.y > display.actualContentHeight/10 then
				nave.y = nave.y-10
			end	
		end
	end
	
end

function moverNaveDOWN(event)

	if event.phase == "began" then
		if nave ~= nil then
			if nave.y < display.actualContentHeight/1.75 then
				nave.y = nave.y+10
			end
		end
	end

end

function moverNaveLEFT(event)

	if event.phase == "began" then
		if nave ~= nil then
			if nave.x > display.actualContentWidth/10 then
				nave.x = nave.x-10
			end
		end
	end

end

function moverNaveRIGHT(event)

	if event.phase == "began" then
		if nave ~= nil then
			if nave.x < display.actualContentWidth/1.1 then
				nave.x = nave.x+10
			end
		end
	end

end

function criarTiro(event)

	if event.phase == "began" then
		if nave ~= nil then
			local contTiro = #tiro+1
			
			tiro[contTiro] = display.newRect(nave.x+15,nave.y,5,3)
			tiro[contTiro].id = contTiro
			
			physics.addBody(tiro[contTiro])

			tiro[contTiro]:setLinearVelocity(100,0)

			--tiro[contTiro]:addEventListener("collision", verificarAcertoInimigo)
		end
	end

end

botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", criarTiro)

local inimigo = nil



function criarInimigos()

	for i= 1, 5 do
		inimigo = display.newRect(math.random(500,500), math.random(80,250),10,10)
		inimigo.id = i
		physics.addBody(inimigo)
		inimigo:setLinearVelocity(-100,0)
		inimigo:addEventListener("collision", verificarAcertoInimigo)
	end

end



function verificarAcertoInimigo(event)

	display.remove(event.target)
	inimigo.id = nil

	display.remove(event.other)
	tiro[event.other] = nil


end

vidaDoBoss = 10

function verificarAcertoBoss(event)

	print("Vida do Boss "..vidaDoBoss)

	vidaDoBoss = vidaDoBoss - 1

	display.remove(event.other)
	tiro[event.other.id] = nil

	if vidaDoBoss == 0 then
		print("Matou o boss")
		display.remove(event.target)
		boss = nil

	end

end

function mostrarVida(contadorVida)
	
	vida = display.newText("Vidas: ".. contadorVida, display.actualContentWidth/7,display.actualContentHeight/11,native.systemFont, 15)
	
end

local contadorVida = 3

mostrarVida(contadorVida)

function verificarVida(event)
	
	contadorVida = contadorVida - 1

	display.remove(event.other)
	inimigo.id = nil

	if contadorVida == 0 then
		display.remove(event.target)
		nave = nil
	end
	
	display.remove(vida)
	mostrarVida(contadorVida)
	
end

nave:addEventListener("collision", verificarVida)

condicaoParaDeCriarInimigos = 1

function gerarInimigos()

	condicaoParaDeCriarInimigos = condicaoParaDeCriarInimigos + 1
		
	if condicaoParaDeCriarInimigos < 7 then

		criarInimigos()

	end
	print("Contador " .. condicaoParaDeCriarInimigos)
	if condicaoParaDeCriarInimigos == 7 then
		
		timer.cancel(gerarInimigo)
		print("Vai gerar o boss")
		gerarBoss()
		
	end

end

gerarInimigo = timer.performWithDelay(3000, gerarInimigos,0)

local boss = nil

function gerarBoss( )
	
	boss = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/3,50,50)
	physics.addBody(boss, "dynamic")
	boss:addEventListener("collision", verificarAcertoBoss)
	--boss:setLinearVelocity(10,10)
	print("Gerou o boss")
	movimentarBoss()
end

function movimentarBoss()
	

end

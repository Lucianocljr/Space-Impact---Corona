
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
--inimigo = {}
--boss = {}

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

			tiro[contTiro]:addEventListener("collision", verificarAcertoInimigo)
			
			tiro[contTiro]:setLinearVelocity(100,0)

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
	end

end

criarInimigos()

function verificarAcertoInimigo(event)

	display.remove(event.target)
	tiro[event.target.id] = nil

	display.remove(event.other)
	inimigo.id = nil

end

vidaDoBoss = 10

function verificarAcertoBoss(event)

	display.remove(evenet.target)
	tiro[event.target.id] = nil

	if vidaDoBoss == 0 then

		display.remove(event.other)
		inimigo[event.other.id] = nil

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


--Daqui pra cima está pronto e funcionando
condicaoParaDeCriarInimigos = 1

testeDoBoss = 1
function gerarInimigos()

	condicaoParaDeCriarInimigos = condicaoParaDeCriarInimigos + 1
		
	if condicaoParaDeCriarInimigos < 6 then

		criarInimigos()

	end

	if condicaoParacriarInimigos == 5 then
	
		gerarInimigo.cancel()
		gerarBoss()

	end

end

gerarInimigo = timer.performWithDelay(3000, gerarInimigos,0)

 

function gerarBoss( )

	local boss = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/3,50,50)
	physics.addBody(boss, "static")
	teste = testeDoBoss
	
		if teste == 5 then
			
		boss.isVisible = true
			
		end
	
end

contMovBoss = 1
function movimentarBoss( )
	
	if boss ~= nil then

		if contMovBoss < 6 then
		boss.y=boss.y-10
		contMovBoss =contMovBoss +1
		end
	end

	if boss ~= nil then
		if contMovBoss >= 6 then
			boss.y = boss.y+10
			contMovBoss = contMovBoss +1
		end
	end

	if boss ~= nil then
		if contMovBoss == 12 then
			contMovBoss = 0
		end
	end
end

movimentoBoss = timer.performWithDelay(1000, movimentarBoss,0)


--physics.addBody(retangulo)
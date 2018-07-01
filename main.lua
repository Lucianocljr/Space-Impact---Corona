
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")

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

cenario = display.newRect(display.actualContentWidth/2.05,display.actualContentHeight/3,display.actualContentWidth/1.1,display.actualContentHeight/1.85)
cenario.strokeWidth = 1
cenario:setFillColor(0)
cenario:setStrokeColor(1,1,1)

nave = display.newRect(display.actualContentWidth/6, display.actualContentHeight/3,10,10)
nave.strokeWidth = 3
nave:setFillColor( 0.1 )
nave:setStrokeColor( 1, 0, 0 ) 
physics.addBody(nave, "static")

tiroInimigo = {}
tiroBoss = {}

function moverNaveUP(event)
	if event.phase == "began" then
		if nave ~= nil then
			if nave.y > display.actualContentHeight/7 then
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

function criartiroInimigo(event)
	if event.phase == "began" then
		if nave ~= nil then
			local contTiroInimigo = #tiroInimigo+1
			tiroInimigo[contTiroInimigo] = display.newRect(nave.x+15,nave.y,5,3)
			tiroInimigo[contTiroInimigo].id = contTiroInimigo
			physics.addBody(tiroInimigo[contTiroInimigo])
			tiroInimigo[contTiroInimigo]:setLinearVelocity(100,0)
			tiroInimigo[contTiroInimigo]:addEventListener("collision", verificarAcertoInimigo)
		end
	end
end

function criarTiroBoss(event)
	if event.phase == "began" then
		if nave ~= nil then
			local contTiroBoss = #tiroBoss+1
			tiroBoss[contTiroBoss] = display.newRect(nave.x+15,nave.y,5,3)
			tiroBoss[contTiroBoss].id = contTiroBoss
			physics.addBody(tiroBoss[contTiroBoss])
			tiroBoss[contTiroBoss]:setLinearVelocity(100,0)
			tiroBoss[contTiroBoss]:addEventListener("collision", verificarAcertoBoss)
		end
	end
end

botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", criartiroInimigo)

local inimigo = nil

function limparInimigo(event)
	display.remove(event.other)
	inimigo.id = nil
end

local linhaCenarioEsquerdo = display.newRect(display.actualContentWidth/50,0,5,display.actualContentWidth*2)
linhaCenarioEsquerdo:setFillColor(0)
physics.addBody(linhaCenarioEsquerdo, "static")
linhaCenarioEsquerdo:addEventListener("collision", limparInimigo)

function criarInimigos()
	for i= 1, 5 do
		inimigo = display.newRect(math.random(200,500), math.random(60,250),10,10)
		inimigo.id = i
		physics.addBody(inimigo)
		inimigo:setLinearVelocity(-100,0)
	end
end

function verificarAcertoInimigo(event)
	display.remove(event.target)
	inimigo.id = nil
	display.remove(event.other)
	tiroInimigo[event.other] = nil
	incrementarPontuacao()
end

vidaDoBoss = 5

function verificarAcertoBoss(event)
	vidaDoBoss = vidaDoBoss - 1
	display.remove(event.target)
	tiroBoss[event.target.id] = nil
	if vidaDoBoss == 0 then
		display.remove(event.other)
		boss = nil
		display.newText("You Win!", display.actualContentWidth/2, display.actualContentHeight/2)
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
	if contadorVida == 0 then
		display.remove(event.target)
		nave = nil
		display.newText("You Lose!", display.actualContentWidth/2, display.actualContentHeight/2)
	end
	display.remove(vida)
	mostrarVida(contadorVida)
end

nave:addEventListener("collision", verificarVida)

condicaoParaDeCriarInimigos = 1

function limparTiroParaGerarBoss()
	for i=1, #tiroInimigo do
		display.remove(tiroInimigo[i])
	end
end

function gerarInimigos()
	condicaoParaDeCriarInimigos = condicaoParaDeCriarInimigos + 1
	if condicaoParaDeCriarInimigos < 6 then
		criarInimigos()
	end
	if condicaoParaDeCriarInimigos == 7 then
		limparTiroParaGerarBoss()
		timer.cancel(gerarInimigo)
		gerarBoss()
	end
end

gerarInimigo = timer.performWithDelay(3000, gerarInimigos,0)

local boss = nil
local ataqueDoBoss = nil
function gerarAtaqueDoBoss(event)
	if event.phase == "began" then
		if vidaDoBoss ~= 0 then
			ataqueDoBoss = display.newRect(boss.x-40, boss.y , 5 ,3)
			physics.addBody(ataqueDoBoss)
			ataqueDoBoss:setLinearVelocity(-100,0)
		end
	end
	linhaCenarioEsquerdo:addEventListener("collision", limparAtaqueDoBoss)
end

function limparAtaqueDoBoss(event)
	display.remove(event.other)
	ataqueDoBoss.id = nil
end

function gerarBoss( )
	boss = display.newRect(display.actualContentWidth/1.3,display.actualContentHeight/3,50,50)
	physics.addBody(boss, "dynamic")
	botaoSHOT:removeEventListener("touch", criartiroInimigo)
	botaoSHOT:addEventListener("touch", criarTiroBoss)
	botaoSHOT:addEventListener("touch", gerarAtaqueDoBoss)

	barraSuperior = display.newRect(display.actualContentWidth/1.1,display.actualContentHeight/9,display.actualContentWidth*2,5)
	barraSuperior:setFillColor(0)
	barraSuperior.surfaceType = "superbounce"
	physics.addBody(barraSuperior, "static",{ bounce=1.0, friction=0.0 })

	local barraInferior = display.newRect(display.actualContentWidth/1.27,display.actualContentHeight/1.63,display.actualContentWidth*2,5)
	barraInferior:setFillColor(0)
	barraInferior.surfaceType = "superbounce"
	physics.addBody(barraInferior, "static",{ bounce=1.0, friction=0.0 })

	linhaCenarioEsquerdo:removeEventListener("collision", limparInimigo)
	movimentarBoss()
end

local contMovBoss = 1

function movimentarBoss(event)
	if contMovBoss%2 == 0 then
		boss:setLinearVelocity(0,50)
		contMovBoss = contMovBoss + 1
	else
		boss:setLinearVelocity(0,-50)
		contMovBoss = contMovBoss + 1
	end
end

function mostrarPontos(pontuacao)
	pontos = display.newText("Score: " .. pontuacao, display.actualContentWidth/1.2,display.actualContentHeight/11,native.systemFont, 15)
end

local pontuacao = 0

mostrarPontos(pontuacao)

function incrementarPontuacao( )	
	pontuacao = pontuacao + 10
	display.remove(pontos)
	mostrarPontos(pontuacao)
end
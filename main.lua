
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")

function criarBotoes()
	botaoUP = display.newRect(display.actualContentWidth/3.1,display.actualContentHeight/1.4,display.actualContentWidth/6,display.actualContentHeight/10)
	botaoUP:setFillColor( 0.35 )
	nomeBotaoUP = display.newText("UP",display.actualContentWidth/3.1,display.actualContentHeight/1.4,native.systemFont,13)
	botaoUP:addEventListener("touch", moverNaveUP)

	botaoDOWN = display.newRect(display.actualContentWidth/3.1,display.actualContentHeight/1.15,display.actualContentWidth/6,display.actualContentHeight/10)
	botaoDOWN:setFillColor( 0.35 )
	nomeBotaoDOWN = display.newText("DOWN",display.actualContentWidth/3.1,display.actualContentHeight/1.15,native.systemFont,13)
	botaoDOWN:addEventListener("touch", moverNaveDOWN)

	botaoLEFT = display.newRect(display.actualContentWidth/7,display.actualContentHeight/1.26,display.actualContentWidth/6,display.actualContentHeight/10)
	botaoLEFT:setFillColor( 0.35 )
	nomeBotaoLEFT = display.newText("LEFT",display.actualContentWidth/7,display.actualContentHeight/1.26,native.systemFont,13)
	botaoLEFT:addEventListener("touch", moverNaveLEFT)

	botaoRIGHT = display.newRect(display.actualContentWidth/1.98,display.actualContentHeight/1.26,display.actualContentWidth/6,display.actualContentHeight/10)
	botaoRIGHT:setFillColor( 0.35 )
	nomeBotaoRIGHT = display.newText("RIGHT",display.actualContentWidth/1.98,display.actualContentHeight/1.26,native.systemFont,13)
	botaoRIGHT:addEventListener("touch", moverNaveRIGHT)

	botaoSHOT = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/1.25,display.actualContentWidth/6,display.actualContentHeight/10)
	botaoSHOT:setFillColor( 0.35 )
	nomeBotaoShot = display.newText("SHOT",display.actualContentWidth/1.2,display.actualContentHeight/1.25,native.systemFont,13)
	botaoSHOT:addEventListener("touch", criarTiroInimigo)
end

function criarCenario( )
	-- body
end

function criarNave()
	--nave = display.newImageRect("nave1.png", 20,20)
	--nave.x = display.actualContentWidth/6
	--nave.y = display.actualContentHeight/3
	nave = display.newRect(display.actualContentWidth/6,display.actualContentHeight/3,10,10)
	nave.strokeWidth = 3
	nave:setStrokeColor(1,0,0)
	physics.addBody(nave, "static")
	nave:addEventListener("collision", verificarVidaQuandoEstiverNosInimigos)
end

local tiroInimigo = {}

local tiroBoss = {}

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
			if nave.x < display.actualContentWidth/1.8 then
				nave.x = nave.x+10
			end
		end
	end
end

function criarTiroInimigo(event)
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

local vidaDoBoss = 5


local venceu = nil
function verificarAcertoBoss(event)
	vidaDoBoss = vidaDoBoss - 1
	display.remove(event.target)
	tiroBoss[event.target.id] = nil

	if vidaDoBoss == 0 then
		display.remove(event.other)
		boss = nil
	venceu = display.newText("You Win!", display.actualContentWidth/2, display.actualContentHeight/2)
		venceu.alpha = 0
		transition.fadeIn(venceu, { time = 2000})
		resetarJogo()
	end
end

local vida = nil

function mostrarVida(contadorVida)
	vida = display.newText("Vidas: ".. contadorVida, display.actualContentWidth/7,display.actualContentHeight/11,native.systemFont, 15)
end

local contadorVida = 3
local perdeuNoInimigo = nil
function verificarVidaQuandoEstiverNosInimigos(event)
	contadorVida = contadorVida - 1
	display.remove(event.other)
	if contadorVida == 0 then
		display.remove(event.target)
		nave = nil
	perdeuNoInimigo = display.newText("You Lose!", display.actualContentWidth/2, display.actualContentHeight/2)
		perdeuNoInimigo.alpha = 0
		transition.fadeIn(perdeuNoInimigo, { time = 2000})
		resetarJogo()
		display.remove(vida)
	else
		display.remove(vida)
	mostrarVida(contadorVida)
	end
	
end

local perdeuNoBoss = nil
function verificarVidaQuandoEstiverNoBoss(event)

	display.remove(event.target)
	display.remove(event.other)
	display.remove(vida)
	mostrarVida(0)

	perdeuNoBoss = display.newText("You Lose!", display.actualContentWidth/2, display.actualContentHeight/2)
	perdeuNoBoss.alpha = 0
	transition.fadeIn(perdeuNoBoss, { time = 2000})
	resetarJogo()
	
end

local condicaoParaDeCriarInimigos = 1

function limparTiroParaGerarBoss()
	for i=1, #tiroInimigo do
		display.remove(tiroInimigo[i])
	end
end

function gerarInimigos()
	condicaoParaDeCriarInimigos = condicaoParaDeCriarInimigos + 1
	if condicaoParaDeCriarInimigos < 6 then --6
		criarInimigos()
	end
	if condicaoParaDeCriarInimigos == 7 then --7
		limparTiroParaGerarBoss()
		timer.cancel(gerarInimigo)
		gerarBoss()
	end
end

local boss = nil

local ataqueDoBoss = nil

function gerarAtaqueDoBoss(event)
	if event.phase == "began" then
		if vidaDoBoss ~= 0 and boss ~= nil then
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

local barraSuperior = nil

local barraInferior = nil

function gerarBoss( )
	--Boss com imagem
	--boss = display.newImageRect("boss.png",50,50)
	--boss.x = display.actualContentWidth/1.3
	--boss.y = display.actualContentHeight/3
	boss = display.newRect(display.actualContentWidth/1.3,display.actualContentHeight/3,50,50)
	physics.addBody(boss, "dynamic")
	botaoSHOT:removeEventListener("touch", criarTiroInimigo)
	botaoSHOT:addEventListener("touch", criarTiroBoss)
	botaoSHOT:addEventListener("touch", gerarAtaqueDoBoss)

	botaoUP:addEventListener("touch", gerarAtaqueDoBoss)
	botaoDOWN:addEventListener("touch", gerarAtaqueDoBoss)
	botaoRIGHT:addEventListener("touch", gerarAtaqueDoBoss)
	botaoLEFT:addEventListener("touch", gerarAtaqueDoBoss)

	barraSuperior = display.newRect(display.actualContentWidth/1.6,display.actualContentHeight/9,display.actualContentWidth/1.6,5)
	barraSuperior:setFillColor(0)
	barraSuperior.surfaceType = "superbounce"
	physics.addBody(barraSuperior, "static",{ bounce=1.0, friction=1.0 })
	
	barraInferior = display.newRect(display.actualContentWidth/1.6,display.actualContentHeight/1.63,display.actualContentWidth/1.5,5)
	barraInferior:setFillColor(0)
	barraInferior.surfaceType = "superbounce"
	physics.addBody(barraInferior, "static",{ bounce=1.0, friction=1.0 })

	linhaCenarioEsquerdo:removeEventListener("collision", limparInimigo)
	movimentarBoss()

	nave:removeEventListener("collision", verificarVidaQuandoEstiverNosInimigos)
	nave:addEventListener("collision", verificarVidaQuandoEstiverNoBoss)
	display.remove(vida)
	mostrarVida(1)
end

local contMovBoss = 1

function movimentarBoss(event)
	if contMovBoss%2 == 1 then
		boss:setLinearVelocity(0,50)
		boss.x = display.actualContentWidth/1.3
		contMovBoss = contMovBoss + 1
	end
end

function mostrarPontos(pontuacao)
	pontos = display.newText("Score: " .. pontuacao, display.actualContentWidth/1.2,display.actualContentHeight/11,native.systemFont, 15)
end

local pontuacao = 0

function incrementarPontuacao( )	
	pontuacao = pontuacao + 10
	display.remove(pontos)
	mostrarPontos(pontuacao)
end

function iniciarPartida(event)
	display.remove(nomeDoJogo)
	display.remove(botaoComecarJogo)
	display.remove(nomeBotaoComecarJogo)
	display.remove(botaoRanking)
	display.remove(nomeBotaoRanking)

	criarNave()
	criarBotoes()
	criarCenario()
	mostrarPontos(pontuacao)
	contadorVida = 3
	mostrarVida(contadorVida)
	condicaoParaDeCriarInimigos = 1
	gerarInimigo = timer.performWithDelay(3000, gerarInimigos,0)
end

function jogarNovamente()
	--tela = display.newRect(display.actualContentWidth/2,display.actualContentHeight/2,display.actualContentWidth/1.01,display.actualContentHeight/1)
	--tela.strokeWidth = 1
	--tela:setFillColor(0)


	nomeDoJogo = display.newText("SPACE IMPACT",display.actualContentWidth/2,display.actualContentHeight/3)

	botaoComecarJogo = display.newRect(display.actualContentWidth/4,display.actualContentHeight/1.5,100,50)
	botaoComecarJogo.strokeWidth = 1
	botaoComecarJogo:setFillColor(0)
	nomeBotaoComecarJogo = display.newText("Jogar", display.actualContentWidth/4, display.actualContentHeight/1.5)
	botaoComecarJogo:addEventListener("touch", iniciarPartida)

	botaoRanking = display.newRect(display.actualContentWidth/1.34,display.actualContentHeight/1.5,100,50)
	botaoRanking.strokeWidth = 1
	botaoRanking:setFillColor(0)
	nomeBotaoRanking = display.newText("Ranking", display.actualContentWidth/1.34, display.actualContentHeight/1.5)
end

function resetarJogo( )
	display.remove(nave)
	display.remove(boss)
	display.remove(botaoUP)
	display.remove(nomeBotaoUP)
	display.remove(botaoDOWN)
	display.remove(nomeBotaoDOWN)
	display.remove(botaoLEFT)
	display.remove(nomeBotaoLEFT)
	display.remove(botaoRIGHT)
	display.remove(nomeBotaoRIGHT)
	display.remove(botaoSHOT)
	display.remove(nomeBotaoShot)
	display.remove(barraSuperior)
	display.remove(barraInferior)
	display.remove(vida)


	pontuacao = 0
	condicaoParaDeCriarInimigos = 1
	contMovBoss = 1
	vidaDoBoss = 5
	contadorVida = 3
	condicaoParaDeCriarInimigos = 8
	jogarNovamente()
end

jogarNovamente()
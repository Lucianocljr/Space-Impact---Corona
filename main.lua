local physics = require("physics")
physics.start()
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

tiro = {}
boss = {}

function moverNaveUP(event)
	
	if event.phase == "began" then
		if nave.y > display.actualContentHeight/10 then
		nave.y = nave.y-10
		end	
	end
	
end

function moverNaveDOWN(event)

	if event.phase == "began" then
		if nave.y < display.actualContentHeight/1.75 then
		nave.y = nave.y+10
		end
	end

end

function moverNaveLEFT(event)

	if event.phase == "began" then
		if nave.x > display.actualContentWidth/10 then
		nave.x = nave.x-10
		end
	end

end

function moverNaveRIGHT(event)

	if event.phase == "began" then
		if nave.x < display.actualContentWidth/1.1 then
		nave.x = nave.x+10
		end
	end

end

contTiro = 1
function criarTiro(event)
	if event.phase == "began" then
	tiro[contTiro] = display.newRect(nave.x,nave.y,5,3)
	contTiro = contTiro + 1
	end
end

function atirar()
	for i = 1 , #tiro do
	tiro[i].x = tiro[i].x + 10
	verificarAcertoInimigo(i)
	verificarAcertoBoss(i)
	end
end

botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", criarTiro)



--inimigos
inimigo = {}
contAuxInimigo = 0
function criarInimigos()
	diferenca = 0
		for i= 1 + contAuxInimigo, 5 + contAuxInimigo do
			inimigo[i] = display.newRect(display.actualContentWidth/1.5+diferenca, display.actualContentHeight/4+diferenca,10,10)
			--inimigo[i].isVisible = true
			diferenca = diferenca + 20
			contAuxInimigo = contAuxInimigo + 1
		end
end
criarInimigos()


function movimetarInimigo()
	for i=1, #inimigo do
		if inimigo[i] ~= nil then
		inimigo[i].x = inimigo[i].x-10
		end
	end
	
	--if inimigo[contAuxInimigo] ~= nil then
	--	inimigo[contAuxInimigo].x = inimigo[contAuxInimigo].x-10
	--end

	verificarVida()
end



--inimigos

function verificarAcertoInimigo(i)
	for a=1, #inimigo do
		if inimigo[a] ~= nil then
			if tiro[i].x > inimigo[a].x and tiro[i].y == inimigo[a].y then
				--inimigo[a].isVisible = false
				display.remove(inimigo[a])
				inimigo[a] = nil
			end
		end
	end	
end

vidaDoBoss = 10
function verificarAcertoBoss(i)
	print("Está entrando na verificarAcertoBoss?")
	if boss[1] ~= nil then
		if tiro[i].y == boss[1].y then
			vidaDoBoss = vidaDoBoss - 1
			--print("Quantidade de vida do boss: " .. vidaDoBoss)
		end
	end

	if vidaDoBoss == 0 then
		display.remove(boss[1])
		boss[1] = nil
		print(boss[1])
	end
end

contadorVida = 3
vida = display.newText("Vidas: ".. contadorVida, display.actualContentWidth/7,display.actualContentHeight/11,native.systemFont, 15)
function verificarVida( )
	teste = false
	for i=1,#inimigo do
		if inimigo[i] ~= nil then
			if inimigo[i].x == nave.x and inimigo[i].y == nave.y then
					contadorVida = contadorVida - 1
					vida.isVisible = false
					vida = display.newText("Vidas: ".. contadorVida, display.actualContentWidth/7,display.actualContentHeight/11,native.systemFont, 15)
					--vida.isVisible = true
					--print("Entrou na verificação da vida")	
			end	
		end
		
		if contadorVida < 0 then
		teste = true
		end
		
	end
	gerarInimigos(teste)
end

--movimentos
movimentoTiro = timer.performWithDelay(100,atirar,0)
movimetoInimigo = timer.performWithDelay(100, movimetarInimigo,0)

--movimentos


condicaoParacriarInimigos = 1
condicaoParaNaoCriarInimigos = 1
testeDoBoss = 1
function gerarInimigos(teste)

	if teste == false then
		--("Está entrando aqui? " .. condicaoParacriarInimigos)
		condicaoParacriarInimigos = condicaoParacriarInimigos + 1
	end

	if condicaoParacriarInimigos == 25 then
		if condicaoParaNaoCriarInimigos < 5 then
		for i=1,5 do
			--inimigo[i] = nil

		end
		criarInimigos()
		condicaoParacriarInimigos = 0
		testeDoBoss = testeDoBoss + 1
		condicaoParaNaoCriarInimigos = condicaoParaNaoCriarInimigos + 1
	end
	end

	gerarBoss(testeDoBoss)

end


--physics.addBody(boss, "static")
 --Estava funcionando a exclusao do boss quando estava criando o boss sen vetor
function gerarBoss(testeDoBoss)
	teste = testeDoBoss
	if boss ~= nil then
		if teste == 5 then
			for i=1, 1 do
				boss[i] = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/3,50,50)
			end
		end
	end
end

contMovBoss = 1
function movimentarBoss( )
	
	if boss[1] ~= nil then
		if contMovBoss < 6 then
		boss[1].y=boss[1].y-10
		contMovBoss =contMovBoss +1
		end
	end

	if boss[1] ~= nil then
		if contMovBoss >= 6 then
			boss[1].y = boss[1].y+10
			contMovBoss = contMovBoss +1
		end
	end

	if boss[1] ~= nil then
		if contMovBoss == 12 then
			contMovBoss = 0
		end
	end
end

--movimentoBoss = timer.performWithDelay(1000, movimentarBoss,0)

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

tiro = {}
inimigo = {}
--boss = {}

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


function criarTiro(event)
	if event.phase == "began" then
	local contTiro = #tiro+1
	print("tiro"..contTiro)
	tiro[contTiro] = display.newRect(nave.x,nave.y,5,3)
	tiro[contTiro].id = contTiro
	print(contTiro)
	physics.addBody(tiro[contTiro])

	tiro[contTiro]:addEventListener("collision", verificarAcertoInimigo)
	function function_name( ... )
		-- body
	end
	timer.performWithDelay(1,function_name)
	tiro[contTiro]:setLinearVelocity(100,0)
	end
end

function atirar()

	for i = 1 , #tiro do
		
		if tiro[i] ~= nil then
		tiro[i].x = tiro[i].x + 10
		end
	end
end

botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", criarTiro)



--inimigos

local contAuxInimigo = 0
function criarInimigos()
	diferenca = 0
		for i= 1 + contAuxInimigo, 5 + contAuxInimigo do
			inimigo[i] = display.newRect(display.actualContentWidth/1.5+diferenca, display.actualContentHeight/4+diferenca,10,10)
			inimigo[i].id = i
			--inimigo[i].isVisible = true
			diferenca = diferenca + 20
			physics.addBody(inimigo[i])
			contAuxInimigo = contAuxInimigo + 1
			inimigo[contAuxInimigo]:setLinearVelocity(-100,0)
		end
end
criarInimigos()


--function movimetarInimigo()
	--for i=1, #inimigo do
	--	if inimigo[i] ~= nil then
	--	inimigo[i].x = inimigo[i].x-10
	--	end
	--end
	
	--if inimigo[contAuxInimigo] ~= nil then
	--	inimigo[contAuxInimigo].x = inimigo[contAuxInimigo].x-10
	--end

	--verificarVida()
--end



--inimigos

function verificarAcertoInimigo(event)
	print("colidiu")
	display.remove(event.target)
	tiro[event.target.id] = nil

	display.remove(event.other)
	inimigo[event.other.id] = nil

end

vidaDoBoss = 10
function verificarAcertoBoss(i)
	--print("Está entrando na verificarAcertoBoss?")
	if boss ~= nil then
		if tiro[i].y == boss.y then
			vidaDoBoss = vidaDoBoss - 1
			--print("Quantidade de vida do boss: " .. vidaDoBoss)
		end
	end

	if vidaDoBoss == 0 then
		display.remove(boss)
		boss = nil
		print(boss)
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
--movimentoTiro = timer.performWithDelay(120,atirar,0)
--movimetoInimigo = timer.performWithDelay(100, movimetarInimigo,0)

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
 --Estava funcionando a exclusao do boss quando estava criando o boss sem vetor
 local boss = display.newRect(display.actualContentWidth/1.2,display.actualContentHeight/3,50,50)
 boss.isVisible = false
function gerarBoss(testeDoBoss)
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
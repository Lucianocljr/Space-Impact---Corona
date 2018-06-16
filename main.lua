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
	verificarAcerto(i)
	end
end

botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", criarTiro)



--inimigos
inimigo = {}
function gerarInimigos()
	diferenca = 10
	for i=1,5 do
		inimigo[i] = display.newRect(display.actualContentWidth/1.5+diferenca, display.actualContentHeight/4+diferenca,10,10)
		diferenca = diferenca + 20
	end
	
end
gerarInimigos()

function movimetarInimigo()

	for i=1,5 do
		inimigo[i].x = inimigo[i].x-20
	end
	
end



--inimigos

function verificarAcerto(i)
	

	for a=1, #inimigo do
		if tiro[i].x == inimigo[a].x and tiro[i].y == inimigo[a].y then
			display.remove(inimigo[a])
			print("Teste de acerto")
		end
	end
		
	
end

contadorVida = 3
vida = display.newText("Vidas: ".. contadorVida, display.actualContentWidth/7,display.actualContentHeight/11,native.systemFont, 15)
function verificarVida( )
	
	for i=1,#inimigo do
		if inimigo[i].x == nave.x then

		contadorVida = contadorVida - 1
		else	
		print("Ainda nao chegou")
		end 

		if contadorVida < 0 then
		return true
		end
		return false
	end
	
end

--movimentos
movimentoTiro = timer.performWithDelay(100,atirar,0)
movimetoInimigo = timer.performWithDelay(1000, movimetarInimigo,0)
--movimentos
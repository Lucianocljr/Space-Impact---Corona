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

nave = display.newRect(display.actualContentWidth/6, display.actualContentHeight/3,10,10)

penteDeBala = {}
function encherOPenteDeBala( )
	for i=1,10 do
		penteDeBala[i] = display.newRect(0,0,10,2) 
	end
end
encherOPenteDeBala()
function moverNaveUP(event)
	
	if event.phase == "began" then
		nave.y = nave.y-10
		movimentarTiro(1)
	end
	
end

function moverNaveDOWN(event)

	if event.phase == "began" then
		nave.y = nave.y+10
		movimentarTiro(1)
	end
	
end

function moverNaveLEFT(event)
	if event.phase == "began" then
		nave.x = nave.x-10
		movimentarTiro(1)
	end
end

function moverNaveRIGHT(event)
	if event.phase == "began" then
		nave.x = nave.x+10
		movimentarTiro(1)
	end
end

function shoot(event)
	teste = false
	if event.phase == "began" then
		teste = true
		atirar(teste)
		movimentarTiro(0)
	end
end


function movimentarTiro(a)

	contador = a
	contAux = 1
	if contador == 1 then
		penteDeBala[contAux].y = nave.y
		penteDeBala[contAux].x = nave.x
		contador = a

	else
		penteDeBala[contAux].x = penteDeBala[contAux].x+10
		contAux = contAux+1
	end
	
end

function atirar(teste)
	if teste == true then
	movimentoTiro = timer.performWithDelay(1000,movimentarTiro,display.actualContentWidth)
	end
end


botaoUP:addEventListener("touch", moverNaveUP)
botaoDOWN:addEventListener("touch", moverNaveDOWN)
botaoLEFT:addEventListener("touch", moverNaveLEFT)
botaoRIGHT:addEventListener("touch", moverNaveRIGHT)
botaoSHOT:addEventListener("touch", shoot)


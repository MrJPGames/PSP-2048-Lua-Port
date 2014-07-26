--load image
img = {}
img[0] = Image.load("0.png")
img[2] = Image.load("2.png")
img[4] = Image.load("4.png")
img[8] = Image.load("8.png")
img[16] = Image.load("16.png")
img[32] = Image.load("32.png")
img[64] = Image.load("64.png")
img[128] = Image.load("128.png")
img[256] = Image.load("256.png")
img[512] = Image.load("512.png")
img[1024] = Image.load("1024.png")
img[2048] = Image.load("2048.png")
img[4096] = Image.load("4096.png")
background = Image.load("background.png")
--load sounds!
white = Color.new(255,255,255)
field = {}
for i = 1, 16, 1 do
	field[i]=0
end
field[math.random(1,16)]=2
done=0
tries=0
while done == 0 do
	rand=math.random(1,16)
	if field[rand] == 0 then
		field[rand]=2
		done=1
	end
	tries=tries+1
	if tries > 100 then
		done=2
	end
end


while done==1 do
pad = Controls.read()
screen:clear()
moved=0
if (pad:left() and not oldpad:left()) then
	for k=0, 3, 1 do
		for j=4, 2, -1 do
			for i=2, j,1 do
				iq=i*4;
				ie=i-1;
				iw=ie*4;
				if field[iq-k] == field[iw-k] then
					field[iw-k] = field[iq-k]*2;
					field[iq-k] = 0;
					moved=1
				end
				if field[iw-k] == 0 and field[iq-k]  > 0 then
					field[iw-k] = field[iq-k];
					field[iq-k] = 0;
					moved=1
				end
			end
		end
	end
end
if (pad:right() and not oldpad:right()) then
	for k=0, 3, 1 do
		for j=1, 3, 1 do
			for i=3,j,-1 do
				iq=i*4;
				ie=i+1;
				iw=ie*4;
				if field[iq-k] == field[iw-k] then
					field[iw-k] = field[iq-k]*2;
					field[iq-k] = 0;
					moved=1
				end
				if field[iw-k] == 0 and field[iq-k]  > 0 then
					field[iw-k] = field[iq-k];
					field[iq-k] = 0;
					moved=1
				end
			end
		end
	end
end
if (pad:up() and not oldpad:up()) then
	for k=0, 3, 1 do
		for j=4, 1, -1 do
			for i=2, j, 1 do
				if (field[i+4*k] == field[i-1+4*k]) then
					field[i+4*k] = field [i-1+4*k]+field[i+4*k]
					field[i-1+4*k] = 0
					moved=1
				end 
				if field[i-1+4*k] == 0 and field[i+4*k] > 0 then
					field[i-1+4*k] = field[i+4*k]
					field[i+4*k] = 0
					moved=1
				end
			end
		end
	end	
end
if (pad:down() and not oldpad:down()) then
	for k=0, 3, 1 do
		for j=1, 3, 1 do
			for i=3, j, -1 do
				if (field[i+4*k] == field[i+1+4*k]) then
					field[i+4*k] = field [i+1+4*k]+field[i+4*k]
					field[i+1+4*k] = 0
					moved=1
				end 
				if field[i+1+4*k] == 0 and field[i+4*k]  > 0 then
					field[i+1+4*k] = field[i+4*k]
					field[i+4*k] = 0
					moved=1
				end
			end
		end
	end	
end
if pad:triangle() then
		done=0
	end
if moved == 1 then
	regen=0
	moved=0
	while regen == 0 do
		rand=math.random(1,16)
		if field[rand] == 0 then
			field[rand]=2
			regen=1
		end
		tries=tries+1
		if tries > 100 then
			regen=2
			curtry=1
			while regen == 2 do
				if curtry == 17 then
					curtry=16
					done=4
					regen=1
				end
				if field[curtry] == 0 then
					field[curtry]=2
					regen=1
				end
				curtry=curtry+1
			end
		end
	end
end
oldpad = pad

curfield=1
screen:blit(0,0,background)
for i = 0, 3, 1 do
	for j = 0, 3, 1 do
		screen:blit(130+i*55+i*2,26+j*55+j*2,img[field[curfield]])
		curfield=curfield+1
	end
end
screen.waitVblankStart()
screen.flip()
end

while done == 2 do
	pad = Controls.read()
	screen:clear()
	screen:print(0,0,"Error press triangle to retry!",white)
	if pad:triangle() then
		done=0
	end
	screen.waitVblankStart()
end

while done == 4 do
pad = Controls.read()
	screen:clear()
	screen:print(0,0,"GameOver!",white)
	if pad:triangle() then
		done=0
	end
	screen.waitVblankStart()
end
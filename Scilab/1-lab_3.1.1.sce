n1 = 8
n2 = 5
n3 = 0
n4 = 6
num = 10 + n3

//direction switch = value: {1} (no-directional) or {0} (directional)
_switch = 0

//matrix
rand("seed", n1 * 1000 + n2 * 100 + n3 * 10 + n4)
T = rand(num,num) + rand(num,num);
A = floor((1.0 - n3 *0.02 - n4 *0.005 - 0.25)*T)        
A2 = A                                                  
A3 = A                                                  
for i = 1:num
    for y = 1:num
        if A2(i, y)
            A2(y, i) = A2(i, y)
        end
    end
end
// matrix for avoiding redo
for i = 1:num
    for u = 1:num
        if (A(i,u) == A(u,i)) && (A(i,u) == 1)
            A(u,i) = 0
        end
    end
end
//vertexes genetaring
plot2d([100, 0],[100, 0],0)
vert = list()               //{1:x, 2:y}
corner = 0
number = 1
diameter = 70
for i = 1 : (num - 1)
    x = diameter./2*cosd(corner) + 50
    y = diameter./2*sind(corner) + 50
    //pushing to the list
    vert($+1) = [x, y]
    xarc(x,y,7,7,0,360*64)
    xnumb(x+2,y-6,number)
    corner = corner + (360./(num - 1))
    number = number + 1
end
//center
xarc(50,50,7,7,0,360*64)
xnumb(50 + 2,50 - 6, number)
//pushing to the list
vert($+1) = [50, 50]

//egdes generating
function edges(bool)
    for i = 1:num
        for u = 1:num
            if A(i ,u)
                x1 = vert(i)(1)
                y1 = vert(i)(2)
                x2 = vert(u)(1)
                y2 = vert(u)(2)
                //cords shifting
                if (u ~= num) || (i ~= num)
                    if (x1 > 75) 
                        y1 = y1 - 3
                    end
                    if (x2 > 75) 
                        y2 = y2 - 3
                    end
                    if (x1 < 75) && (y1 < 25) 
                        x1 = x1 + 4
                    end
                    if (x2 < 75) && (y2 < 25) 
                        x2 = x2 + 3
                    end
                    if (x1 < 30) && (y1 < 75) 
                        x1 = x1 + 7
                        y1 = y1 - 3
                    end
                    if (x2 < 30) && (y2 < 75)
                        x2 = x2 + 7
                        y2 = y2 - 3
                    end
                    if (y1 > 75) 
                        x1 = x1 + 3
                        y1 = y1 - 7
                    end
                    if (y2 > 75) 
                        x2 = x2 + 3
                        y2 = y2 - 7  
                    end
                end
                //coords for the central vertex
                if (i == num)
                    if y2 > 50
                        x1 = x1 + 3
                    else
                        x1 = x1 + 3
                        y1 = y1 - 7 
                    end
                end
                if (u == num)
                    if y1 > 50
                        x2 = x2 + 3
                    else
                        x2 = x2 + 3
                        y2 = y2 - 7
                    end
                end
                //output
                if bool
                    xsegs([x1, x2], [y1,y2],6)
                else
                    xarrows([x1, x2], [y1,y2], 50, 5)
                    if (A3(i,u) == A3(u,i))                    
                        if (i == num)
                            //increments
                            a = 0
                            b = 0
                            c = 0
                            d = 0
                            if y2 > 55
                                if x1 > 55
                                    a = 7
                                    b = -2
                                else
                                    a = 0
                                    b = -2 
                                end
                                c = 4
                                d = -7
                                _x1 = vert(i)(1) + a
                                _y1 = vert(i)(2) + b
                                _x2 = vert(u)(1) + c
                                _y2 = vert(u)(2) + d
                            elseif y2 < 50
                                if x2 > 55
                                    a = 7
                                    b = -4
                                    c = 1
                                    d = -2
                                else
                                    a = 2
                                    b = -2
                                    c = 7
                                    d = -4
                                end
                                _x1 = vert(i)(1) + a
                                _y1 = vert(i)(2) + b
                                _x2 = vert(u)(1) + c
                                _y2 = vert(u)(2) - d
                            end
                        end
                        if (u == num)
                            if y1 > 55
                                if x1 > 55
                                    a = 7
                                    b = -2
                                else
                                    a = 0
                                    b = -2 
                                end
                                c = 4
                                d = -7
                                _x2 = vert(u)(1) + a
                                _y2 = vert(u)(2) + b
                                _x1 = vert(i)(1) + c
                                _y1 = vert(i)(2) + d
                            elseif y1 < 50
                                if x2 > 55
                                    a = 7
                                    b = -4
                                    c = 1
                                    d = -2
                                else
                                    a = 2
                                    b = -2
                                    c = 7
                                    d = -4
                                end
                                _x2 = vert(u)(1) + a
                                _y2 = vert(u)(2) + b
                                _x1 = vert(u)(1) + c
                                _y1 = vert(u)(2) + d
                            end
                            xarrows([_x2, _x1], [_y2 ,_y1], 50, 5)
                        end
                    end
                end
            end
        end
    end
endfunction

edges(_switch)    //arg: {1} (no-directional) or {0} (directional)

//matrix output
disp(A3, "Матриця суміжності орієнтованого графа")
disp(A2, "Матриця суміжності неорієнтованого графа")
halt()
xdel()

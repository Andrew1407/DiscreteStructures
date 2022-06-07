n1 = 8
n2 = 5
n3 = 0
n4 = 6
num = 10 + n3

// [PART 1 (lab 1)]

//direction switch = value: {1} (no-directional) or {0} (directional)
bool = 1

//matrix
rand("seed", n1 * 1000 + n2 * 100 + n3 * 10 + n4);
T = rand(num,num) + rand(num,num);
A = floor((1.0 - n3 *0.01 - n4 *0.005 - 0.05)*T)
_A = A
disp(A, "Матриця суміжності орієнтованого графа:")
//weight
Wt = round(rand(num,num)*100 .* A);
B = Wt & ones(num,num);
Wt = (bool2s(B & ~B') + bool2s(B & B') .* tril(ones(num,num),-1)) .* Wt;
W = Wt + Wt';
_V = 0
function Graph(A, bool, STR)     
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
    //vertices genetaring
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
    for i = 1:num
        for u = 1:num
            if (u == i) && A3(i,u)
                x = vert(i)(1) 
                y = vert(u)(2) - 2
                xsegs([x, x - 5], [y, y - 5], 2)
                xsegs([x - 5, x - 5], [y - 5, y + 5], 2)
                if bool
                    xsegs([x - 5, x], [y + 5 , y], 2)
                else
                    xarrows([x - 5, x], [y + 5 , y], 30, 2) 
                end
                xnumb((x + x)/2 - 8, (y + y)/2, W(u,i))
                continue
            end
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
                    xnumb((x1 + x2)/2, (y1 + y2)/2, W(u,i))
                else
                    xnumb((x1 + x2)/2, (y1 + y2)/2, W(u,i))
                    xarrows([x1, x2], [y1,y2], 30, 5)
                    if (A3(i,u) == A3(u,i)) && (i < u)
                        a = 2
                        b = -6
                        c = 4
                        d = 0
                        _x1 = vert(i)(1)
                        _y1 = vert(i)(2)
                        _x2 = vert(u)(1)
                        _y2 = vert(u)(2)
                        if (u == num)
                            if (x1 >= 60) && (y1 >= 45)
                                a = 5
                                b = -7
                                c = 7
                                d = -2
                            elseif (x1 < 60) && (y1 >= 45)
                                c = 1
                                d = -1
                                a = 7
                                b = -5
                            elseif (x1 < 60) && (y1 <= 45)
                                c = 2
                                d = -8
                                a = 5
                                b = -10
                            elseif (x1 >= 60) && (y1 <= 45)
                                c = 6
                                d = -6
                                a = 5
                                b = 0
                            end                                
                        end
                        xnumb((x1 + x2)/2 - 2, (y1 + y2)/2 - 2, W(u,i))
                        xarrows([_x2 + c, _x1 + a], [_y2 + d,_y1 + b], 30, 5)
                    end
                end
            end
        end
    end
    _A = A3
    if bool
        _A = A2
    end
    disp(_A, STR)
endfunction

Graph(A, bool, "Матриця суміжності неорієнтованого графа:")
halt("Пошук мінімального кістяка за алгоритмом Краскала")
xdel()

// [Part 2 (lab 5)]

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
//vertices genetaring
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

// alhorithm
E = list()
We = list()
Egs = list()
Wg = list()
M = zeros(num, num)
halt()
for i = 1:num
    for u = 1:num
        if A(i, u) && (i ~= u)
            E($+1) = [i ,u]
            We($+1) = W(i, u)
        end
    end
end

while %T
    min = We(1)                 //min weight
    n = 1                       //list index
    Flag = %F
    for z = 2:length(We)
        if min > We(z)
            min = We(z)
            n = z
        end
    end     
    if length(Egs) < 2
        Egs($+1) = E(n)
        Wg($+1) = min
        ii = E(n)
        M(ii(1), ii(2)) = 1
        E(n) = null()
        We(n) = null()
    else
        _ways = list()
        for k = 1:length(Egs)
            _ways($+1) = M^k
        end
        flag = %T
        for t = _ways
            if t(E(n)(1), E(n)(2))
                flag = %F
                break
            end
        end
        ii = E(n)
        if flag
            Egs($+1) = E(n)
            Wg($+1) = min
            M(ii(1), ii(2)) = 1
            E(n) = null()
            We(n) = null()
        else
            E(n) = null()
            We(n) = null()
            Flag = %T
        end
    end
    if Flag
        continue
    end
    //plotting
    for i = ii
        for u = 1:num
            //coords
            if (u == i) && A3(i,u)
                x = vert(i)(1) 
                y = vert(u)(2) - 2
                xsegs([x, x - 5], [y, y - 5], 2)
                xsegs([x - 5, x - 5], [y - 5, y + 5], 2)
                if bool
                    xsegs([x - 5, x], [y + 5 , y], 2)
                else
                    xarrows([x - 5, x], [y + 5 , y], 30, 2)
                end
                xnumb((x + x)/2 - 8, (y + y)/2, W(u,i))
                continue
            end
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
                xnumb((x1 + x2)/2, (y1 + y2)/2, W(i, u))
                if bool
                    xsegs([x1, x2], [y1,y2], 6)
                else
                    xarrows([x1, x2], [y1,y2], 30, 5)
                    if (A3(i,u) == A3(u,i)) && (i < u)
                        a = 2
                        b = -6
                        c = 4
                        d = 0
                        _x1 = vert(i)(1)
                        _y1 = vert(i)(2)
                        _x2 = vert(u)(1)
                        _y2 = vert(u)(2)
                        if (u == num)
                            if (x1 >= 60) && (y1 >= 45)
                                a = 5
                                b = -7
                                c = 7
                                d = -2
                            elseif (x1 < 60) && (y1 >= 45)
                                c = 1
                                d = -1
                                a = 7
                                b = -5
                            elseif (x1 < 60) && (y1 <= 45)
                                c = 2
                                d = -8
                                a = 5
                                b = -10
                            elseif (x1 >= 60) && (y1 <= 45)
                                c = 6
                                d = -6
                                a = 5
                                b = 0
                            end                                
                        end
                        xnumb((x1 + x2)/2 - 3, (y1 + y2)/2 - 3, W(u,i))
                        xarrows([_x2 + c, _x1 + a], [_y2 + d,_y1 + b], 30, 5)
                    end
                end
            end
        end
    end
    if length(Egs) == (num - 1)
        break
    end
    disp("До кістяка додано ребро " + "E(" + string(ii(1)) + ", " + string(ii(2)) + ")")
    halt('')
end
halt("Кінець обходу")
//tree output
disp("Знайдений кістяк")
scf()
Graph(M, bool, "Матриця суміжності кістяка гарфу:")
halt()
xdel()
xdel()

n1 = 8
n2 = 5
n3 = 0
n4 = 6
num = 10 + n3

// [PART 1 (lab 1)]

bool = 1        //direction switch = value: {1} (no-directional) or {0} (directional)

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
halt("Пошук найкоротшого шляху за алгоритмом Дейкстри")

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
scf()
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

// [Alhorithm]
Ways = list()               //the shortest ways
Ways_weight = list()    
P = list()                  //permanent vertices
We = list()                 //ways weights
for i = 1:num
    We($+1) = %inf
end
//firts vertex search
for i = 1:num
    for u = 1:num
        if A2(i, u)
            We(i) = 0
            break
        end
    end
    if A2(i, u)
        break
    end
end
FIRST = i

xset("color", 5)
halt('')
disp("Початкова активна вершина: " + string(i))
xarc(vert(i)(1),vert(i)(2),7,7,0,360*64)

//main cycle
while %T
    //girth of neighbours
    for t = 1:num
        if (t ~= i) && A2(i, t)
            //searching {t} in {P} list
            flag = %F
            for v = P
                if v == t
                    flag = %T
                    break
                end
            end
            if flag
                continue
            end
            _w = We(i) + W(i, t)
            if _w < We(t)
                We(t) = _w
            end
            //Ways search
            if i == FIRST
                Ways($+1) = list(FIRST, t)
                Ways_weight($+1) = _w
            else
                for b = 1:length(Ways)
                    if Ways(b)(length(Ways(b))) == i
                        Ways($+1) = lstcat(Ways(b), list(t))
                        Ways_weight($+1) = _w
                    end
                end
            end
        end
    end
    P($+1) = i
    //plotting
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
    if length(P) == num
        break
    end
    //new permanent vertex choosing
    _weight = -1
    for p = 1:num
        //searching {p} in {P} list
        flag = %F
        for q = P
            if p == q
                flag = %T
                break
            end
        end
        if flag
            continue
        end
        if _weight < 0
            _weight = We(p)
            i = p
        elseif We(p) < _weight
            _weight = We(p)
            i = p
        end
    end
    halt('')
    disp("Чергова активна вершина: " + string(i))
    xarc(vert(i)(1),vert(i)(2),7,7,0,360*64)
end
halt("Кінець обходу")
//ways output
for i = 1:num
    if i == FIRST
        continue
    end
    for h = 1:length(Ways)
        if (i == Ways(h)(length(Ways(h)))) && (We(i) == Ways_weight(h))
            str = ""
            for t = 1:length(Ways(h))
                if t == length(Ways(h))
                    str = str + string(Ways(h)(t))
                else
                    str = str + string(Ways(h)(t)) + " -> "
                end
            end
            break
        end
    end
    Str = "Найкоротший шлях від " + string(FIRST) + " до " + string(i) + " рівний " + string(We(i)) + "; його повний маршрут:"
    disp(Str)
    disp(str)
    disp('')
end
halt()
xdel()
xdel()

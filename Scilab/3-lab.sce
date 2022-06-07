n1 = 8
n2 = 5
n3 = 0
n4 = 6
num = 10 + n3

//direction switch = value: {1} (no-directional) or {0} (directional)
_switch = 0

// [PART 1 (lab 1)]

//matrix
rand("seed", n1 * 1000 + n2 * 100 + n3 * 10 + n4);
T = rand(num,num) + rand(num,num);
A = floor((1.0 - n3 *0.005 - n4 *0.005 - 0.27)*T)     
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
plot2d([200, 0],[100, 0],0)
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
disp(A3, "Матриця суміжності орієнтованого графа:")

// [PART 2 (lab 2)]

vert = list()                 //list for all the vertexes
isolated = list()             //isolated vertexes
pendulous = list()            //pendulous ones
counter = 0

//powers output
// disp("Степені вершин неорієнтованого графа:")
for i = 1:num
    for u = 1:num
        if A2(i,u)
            counter = counter + 1
        end
    end
    //filling lists
    if counter == 0
        isolated($+1) = i
    elseif counter == 1
        pendulous($+1) = i
    end
    // disp("Степінь вершини δ(" + string(i) + ") = " + string(counter))
    //pushing to the list
    vert($+1) = counter
    counter = 0
end

// in/out powers
pows = list()               //{1: δ(+), 2: δ(-)}
for i = 1:num
    pows($+1) = [0, 0]
end
    
for i = 1:num
    for u = 1:num
        if A3(i,u)
            pows(i)(1) = pows(i)(1) + 1
            pows(u)(2) = pows(u)(2) + 1
        end
    end
end

disp("Напівстепені виходу та заходу напрямленого графа:")
for i = 1:num
    disp("Вершина " + string(i) + ":")
    disp("δ(-) = " + string(pows(i)(2)), "δ(+) = " + string(pows(i)(1)))
end

// [PART 3 (lab 3)]

//matrixes of pathes
E = A3
E2 = E^2
E3 = E^3
//[length 2]
disp(E2, "[E^2]:")
disp("Шляхи довжиною 2:")
ways_3 = list()                       //ways with length 3
s = " -> "
for i = 1:num
    for u = 1:num
        if E(i,u)
            for t = 1:num
                if E(u,t)
                    disp(string(i) + s + string(u) + s + string(t))
                    for z = 1:num
                        if E(t,z)
                            //pushing {len 3} to the list
                            ways_3($+1) = [i, u, t, z]
                        end
                    end
                end
            end
        end
    end
end
//[length 3]
disp(E3, "[E^3]:")
disp("Шляхи довжиною 3:")
for i = 1:length(ways_3)
    str = string(ways_3(i)(1))
    for u = 2:4
        str = str + s + string(ways_3(i)(u))
    end
    disp(str)
end
//matrix of reach
R = eye(num, num)
for i = 1:(num - 1)
    R = R + E^i
end
for i = 1:num
    for u = 1:num
        if R(i,u)
            R(i,u) = 1
        end
    end
end
//output
disp(R, "Матриця досяжності R(bool):")
S = R .* (R')
disp(S, "Матриця зв`язності S:")
//components
comp = list(list(1))
i = 2
while i <= num
    c = 1
    len = length(comp)
    flag = %T
    while c <= len
        el = comp(c)(1)
        for u = 1:num
            if S(i,u) ~= S(el, u)
                flag = %F
                break
            end
        end
        if flag
            comp(c)($+1) = i
            break
        end
        flag = %T
        c = c + 1
    end
    if c == (len + 1)
        comp($+1) = list(i)
    end
    i = i + 1
end
//output
c = 1
for i = 1:length(comp)
    str = ""
    for u = 1:length(comp(i))
        if u == length(comp(i))
            s = ""
        else
            s = ", "
        end
        str = str + string(comp(i)(u)) + s
    end
    disp("Компонента " + string(c) + ": {" + str + "}")
    c = c + 1
end
//graph
vert = list()               //{1:x, 2:y}
corner = 0
number = 1
diameter = 40
for i = 1:length(comp)
    x = diameter./2*cosd(corner) + 160
    y = diameter./2*sind(corner) + 50
    //pushing to the list
    vert($+1) = [x, y]
    xarc(x,y,7,7,0,360*64)
    xnumb(x+2,y-6,number)
    corner = corner + (360./length(comp))
    number = number + 1
end
//edges
edges = list()          //{1: start, 2: end}
for i = 1:length(comp)
    for u = 1:length(comp(i)) 
        for t = 1:length(comp)
            if i == t
                continue
            end
            for z = 1:length(comp(t))
                if E(comp(i)(u),comp(t)(z))
                    // disp([i,t])
                    edges($+1) = [i,t]
                    break
                end
            end
        end
    end
end

for i = 1:length(edges)
    s = edges(i)(1)
    f = edges(i)(2)
    x1 = vert(s)(1)
    y1 = vert(s)(2)
    x2 = vert(f)(1)
    y2 = vert(f)(2)
    a = 0
    b = 0
    c = 0
    d = 0
    if x1 < 155
        a = 7
        c = -3
    elseif x1 > 165
        a = 0
        c = -3
    else
        if y1 > 46
            c = -7
        end
        a = 3
    end
    if x2 < 155
        b = 7
        d = -3
    elseif x2 > 165
        b = 0
        d = -3
    else
        if y2 > 46
            d = -7
        end
        b = 3
    end
    xarrows([x1 + a, x2 + b], [y1 + c ,y2 + d], 50, 6)
end
//components matrix
C = zeros(length(vert), length(vert))
for i = 1:length(edges)
    C(edges(i)(1), edges(i)(2)) = 1
end
disp(C, "Матриця суміжності графа конденсації:")
halt()
xdel()

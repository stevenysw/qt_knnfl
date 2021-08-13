function [x1, x2] = genran(n)
  x1 = zeros(1, n);
  x2 = zeros(1, n);
  for i = 1:n
    u = rand;
    if u <= 0.2
      u1 = unifrnd(0,0.96);
      if u1 <= 0.4
          x1(i) = rand;
          x2(i) = unifrnd(0, 0.4);
      end
      if u1 > 0.4 && u1 <= 0.48
          x1(i) = unifrnd(0, 0.4);
          x2(i) = unifrnd(0.4, 0.6);
      end
      if u1 > 0.48 && u1 <= 0.56
          x1(i) = unifrnd(0.6, 1);
          x2(i) = unifrnd(0.4, 0.6);
      end
      if u1 > 0.56
          x1(i) = rand;
          x2(i) = unifrnd(0.6, 1);
      end
    end
    if u > 0.2 && u <= 0.84
      x1(i) = unifrnd(0.45, 0.55);
      x2(i) = unifrnd(0.45, 0.55);
    end
    if u > 0.84
      u1 = unifrnd(0,0.03);
      if u1 <= 0.01
          x1(i) = unifrnd(0.4, 0.6);
          x2(i) = unifrnd(0.4, 0.45);
      end
      if u1 > 0.01 && u1 <= 0.015
          x1(i) = unifrnd(0.4, 0.45);
          x2(i) = unifrnd(0.45, 0.55);
      end
      if u1 > 0.015 && u1 <= 0.02
          x1(i) = unifrnd(0.55, 0.6);
          x2(i) = unifrnd(0.45, 0.55);
      end
      if u1 > 0.02
          x1(i) = unifrnd(0.4, 0.6);
          x2(i) = unifrnd(0.55, 0.6);
      end
    end
  end
end

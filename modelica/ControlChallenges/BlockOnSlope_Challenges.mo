within ControlChallenges;

package BlockOnSlope_Challenges
   
model BlockOnSlope
    final parameter SI.Voltage sat = 20;
    final parameter SI.Acceleration g = 9.81;
    final parameter SI.Mass m = 1;
    parameter SI.CoefficientOfFriction mu = 1 "coulomb friction coefficient";
    parameter Real slope = 1 "slope in percentage";
    final parameter SI.ElectricalForceConstant kf = 20 "torque constant";
    parameter SI.Position x0 = 0 "init position";
    final parameter Real r = sin(slope) "slope coefficient conversion";
    Real usat;
    SI.Position x;
    SI.Velocity xd;
    SI.Force F;
    Modelica.Blocks.Interfaces.RealVectorOutput y[2] annotation(
      Placement(transformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  initial equation
    x = x0;
  equation
    der(x) = xd;
    usat = max(min(u,sat),-sat);
    
    der(xd) = F/m - r*g/m - mu*xd/m;
    der(F) = -kf*F + kf*usat;
    y[1] = x;
    y[2] = xd;
    annotation(
      Diagram,
      Icon(graphics = {Rectangle(origin = {1, -10}, rotation = 45, lineThickness = 1.5, extent = {{-71, 44}, {71, -44}}), Polygon(origin = {-33, 34}, rotation = 45, lineThickness = 0.75, points = {{-79, -12}, {63, -12}, {79, 12}, {-53, 12}, {-79, -12}}), Polygon(origin = {49, 56}, rotation = 45, lineThickness = 0.75, points = {{-7, -54}, {9, -28}, {7, 54}, {-9, 32}, {-7, -54}})}));
  end BlockOnSlope;

  package Examples
  model WithFriction
  parameter Real Kone = 337;
  parameter Real Ktwo = 64;
  BlockOnSlope blockOnSlope(mu = 1, slope = 0, x0 = 0)  annotation(
        Placement(transformation(origin = {58, 8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step step(height = 2, startTime = 1, offset = 0)  annotation(
        Placement(transformation(origin = {-100, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold1111(samplePeriod = 0.02, ySample(fixed = false)) annotation(
        Placement(transformation(origin = {10, 8}, extent = {{-10, -10}, {10, 10}})));
  FullStateFeedback fullStateFeedback(K1 = Kone, K2 = Ktwo)  annotation(
        Placement(transformation(origin = {-34, 10}, extent = {{-10, -10}, {10, 10}})));
    equation
  connect(fullStateFeedback.u, zeroOrderHold1111.u) annotation(
        Line(points = {{-24, 10}, {-2, 10}, {-2, 8}}, color = {0, 0, 127}));
  connect(zeroOrderHold1111.y, blockOnSlope.u) annotation(
        Line(points = {{22, 8}, {48, 8}}, color = {0, 0, 127}));
  connect(blockOnSlope.y, fullStateFeedback.y) annotation(
        Line(points = {{68, 8}, {84, 8}, {84, -44}, {-34, -44}, {-34, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(fullStateFeedback.ref, step.y) annotation(
        Line(points = {{-44, 10}, {-89, 10}}, color = {0, 0, 127}));
    annotation(
        experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.01));
end WithFriction;
  end Examples;

  model FullStateFeedback
  
  parameter Real K1;
  parameter Real K2;
  Modelica.Blocks.Interfaces.RealInput ref annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealVectorInput y[2] annotation(
      Placement(transformation(origin = {0, -98}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -98}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
      Placement(transformation(origin = {102, 2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {102, 2}, extent = {{-10, -10}, {10, 10}})));
  equation
  u = (ref-y[1])*K1  - y[2]*K2; 
  

  annotation(
      Diagram,
  Icon(graphics = {Text(origin = {112, -4}, extent = {{-226, -96}, {0, 96}}, textString = "-K", fontName = "Georgia")}));
end FullStateFeedback;
end BlockOnSlope_Challenges;

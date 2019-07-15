(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 10.4' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[     31910,        843]
NotebookOptionsPosition[     31027,        793]
NotebookOutlinePosition[     31525,        814]
CellTagsIndexPosition[     31482,        811]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[BoxData[""], "Input"],

Cell[CellGroupData[{

Cell["\<\
Note that the distributions shown here are not normalised. We are only \
looking at a small portion of the distribution that actually stretches to \
infinity.\
\>", "Item"],

Cell[TextData[{
 "This section demonstrates how the shape of a normalised pareto (which is a \
power law distribution) distribution changes with \[Alpha] and xm. Pareto \
distributions are given by P(x) = ",
 Cell[BoxData[
  FormBox[
   FractionBox[
    RowBox[{"\[Alpha]", " ", 
     SuperscriptBox["xm", "\[Alpha]"]}], 
    SuperscriptBox["x", 
     RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]], TraditionalForm]]],
 "; \[Alpha], xm, x > 0"
}], "Item"],

Cell["\<\
We see that xm simply scales the curve while \[Alpha] affects how steeply the \
distribution decays - higher the \[Alpha], steeper the fall\
\>", "Item"],

Cell["\<\
Note that the range for pareto is defined as x \[Epsilon] [xmin, infinity]\
\>", "Item"],

Cell["Feel free to adjust the plot ranges as convenient", "Item"],

Cell["\<\
The distribution is plotted on log-linear axes as well as linear-linear axes\
\>", "Item"],

Cell["\<\
To see values of parameters (xmin and \[Alpha]) click on the + sign next to \
the sliders.\
\>", "Item"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"LogPlot", "[", 
      RowBox[{
       FormBox[
        FractionBox[
         RowBox[{"\[Alpha]", "*", 
          SuperscriptBox["xm", "\[Alpha]"]}], 
         SuperscriptBox["x", 
          RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]],
        TraditionalForm], " ", ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "0.001", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "Full"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Log-linear plot\>\""}]}], "]"}], 
     "\[IndentingNewLine]", 
     RowBox[{"Plot", "[", 
      RowBox[{
       FormBox[
        FractionBox[
         RowBox[{"\[Alpha]", "*", 
          SuperscriptBox["xm", "\[Alpha]"]}], 
         SuperscriptBox["x", 
          RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]],
        TraditionalForm], " ", ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "xm", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "Full"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Non-log plot\>\""}], ",", 
       RowBox[{"AxesOrigin", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{"0", ",", "0"}], "}"}]}]}], "]"}]}], "\[IndentingNewLine]", 
    ",", 
    RowBox[{"{", 
     RowBox[{"xm", ",", "0.1", ",", "10"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Alpha]", ",", "0.1", ",", "10"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`xm$$ = 
    3.0100000000000002`, $CellContext`\[Alpha]$$ = 3.08, Typeset`show$$ = 
    True, Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`xm$$], 0.1, 10}, {
      Hold[$CellContext`\[Alpha]$$], 0.1, 10}}, Typeset`size$$ = {
    723., {116., 121.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`xm$510761$$ = 
    0, $CellContext`\[Alpha]$510762$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`xm$$ = 0.1, $CellContext`\[Alpha]$$ = 0.1},
       "ControllerVariables" :> {
        Hold[$CellContext`xm$$, $CellContext`xm$510761$$, 0], 
        Hold[$CellContext`\[Alpha]$$, $CellContext`\[Alpha]$510762$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      LogPlot[$CellContext`\[Alpha]$$ \
($CellContext`xm$$^$CellContext`\[Alpha]$$/$CellContext`x^($CellContext`\
\[Alpha]$$ + 1)), {$CellContext`x, 0.001, 100}, PlotRange -> Full, ImageSize -> 
         Medium, PlotLabel -> "Log-linear plot"] 
       Plot[$CellContext`\[Alpha]$$ \
($CellContext`xm$$^$CellContext`\[Alpha]$$/$CellContext`x^($CellContext`\
\[Alpha]$$ + 1)), {$CellContext`x, $CellContext`xm$$, 100}, PlotRange -> Full,
          ImageSize -> Medium, PlotLabel -> "Non-log plot", 
         AxesOrigin -> {0, 0}], 
      "Specifications" :> {{$CellContext`xm$$, 0.1, 
         10}, {$CellContext`\[Alpha]$$, 0.1, 10}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{768., {174., 179.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[TextData[{
 "This section demonstrates how the shape of a normalised lognormal \
distribution changes with \[Mu] and \[Sigma]. Lognormal distributions are \
given by P(x) = ",
 Cell[BoxData[
  FormBox[
   FractionBox["1", 
    RowBox[{"x\[Sigma]", 
     SqrtBox[
      RowBox[{"2", " ", "\[Pi]"}]]}]], TraditionalForm]]],
 Cell[BoxData[
  FormBox[
   SuperscriptBox["e", 
    FractionBox[
     RowBox[{"-", 
      SuperscriptBox[
       RowBox[{"(", 
        RowBox[{
         RowBox[{"ln", " ", "x"}], " ", "-", " ", "\[Mu]"}], ")"}], "2"]}], 
     RowBox[{"2", " ", 
      SuperscriptBox["\[Sigma]", "2"]}]]], TraditionalForm]]],
 "; \[Mu], \[Sigma], x > 0"
}], "Item"],

Cell["\<\
As \[Sigma] increases, the tail of the distribution thickens, making large x \
values more likely. Also, as \[Sigma] increases, the peak of the distribution \
shifts to the left, making smaller x values more frequent\
\>", "Item"],

Cell["\<\
As \[Mu] increases, the tail widens, once again making large x calues more \
likely. Also, with increase in \[Mu], the peak shifts to the right, making \
smaller x values less likely.\
\>", "Item"],

Cell["Feel free to adjust the plot ranges as convenient", "Item"],

Cell["\<\
The distribution is plotted on log-linear axes as well as linear-linear axes\
\>", "Item"],

Cell["\<\
To see values of parameters click on the + sign next to the sliders.\
\>", "Item"]
}, Open  ]],

Cell[BoxData[""], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"LogPlot", "[", 
      RowBox[{
       FormBox[
        RowBox[{" ", 
         FormBox[
          FractionBox[
           RowBox[{"Exp", "[", 
            FractionBox[
             RowBox[{"-", 
              SuperscriptBox[
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"Log", "[", "x", "]"}], "-", " ", "\[Mu]"}], ")"}], 
               "2"]}], 
             RowBox[{"2", "*", 
              SuperscriptBox["\[Sigma]", "2"]}]], "]"}], 
           RowBox[{"x", "*", "\[Sigma]", "*", 
            SqrtBox[
             RowBox[{"2", "*", "\[Pi]"}]]}]],
          TraditionalForm]}],
        TraditionalForm], ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "0.001", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Log-linear plot\>\""}]}], "]"}], 
     "\[IndentingNewLine]", 
     RowBox[{"Plot", "[", 
      RowBox[{
       FormBox[
        RowBox[{" ", 
         FormBox[
          FractionBox[
           RowBox[{"Exp", "[", 
            FractionBox[
             RowBox[{"-", 
              SuperscriptBox[
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"Log", "[", "x", "]"}], "-", " ", "\[Mu]"}], ")"}], 
               "2"]}], 
             RowBox[{"2", "*", 
              SuperscriptBox["\[Sigma]", "2"]}]], "]"}], 
           RowBox[{"x", "*", "\[Sigma]", "*", 
            SqrtBox[
             RowBox[{"2", "*", "\[Pi]"}]]}]],
          TraditionalForm]}],
        TraditionalForm], ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "0.001", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Non-log plot\>\""}]}], "]"}]}], 
    "\[IndentingNewLine]", ",", 
    RowBox[{"{", 
     RowBox[{"\[Mu]", ",", "0.1", ",", "10"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Sigma]", ",", "0.1", ",", "10"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`\[Mu]$$ = 8.79, $CellContext`\[Sigma]$$ = 
    7.14, Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`\[Mu]$$], 0.1, 10}, {
      Hold[$CellContext`\[Sigma]$$], 0.1, 10}}, Typeset`size$$ = {
    723., {119., 123.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`\[Mu]$290293$$ = 
    0, $CellContext`\[Sigma]$290294$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`\[Mu]$$ = 0.1, $CellContext`\[Sigma]$$ = 
        0.1}, "ControllerVariables" :> {
        Hold[$CellContext`\[Mu]$$, $CellContext`\[Mu]$290293$$, 0], 
        Hold[$CellContext`\[Sigma]$$, $CellContext`\[Sigma]$290294$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      LogPlot[Exp[(-(Log[$CellContext`x] - $CellContext`\[Mu]$$)^2)/(
           2 $CellContext`\[Sigma]$$^2)]/(($CellContext`x $CellContext`\
\[Sigma]$$) Sqrt[2 Pi]), {$CellContext`x, 0.001, 100}, PlotRange -> All, 
         ImageSize -> Medium, PlotLabel -> "Log-linear plot"] 
       Plot[Exp[(-(Log[$CellContext`x] - $CellContext`\[Mu]$$)^2)/(
           2 $CellContext`\[Sigma]$$^2)]/(($CellContext`x $CellContext`\
\[Sigma]$$) Sqrt[2 Pi]), {$CellContext`x, 0.001, 100}, PlotRange -> All, 
         ImageSize -> Medium, PlotLabel -> "Non-log plot"], 
      "Specifications" :> {{$CellContext`\[Mu]$$, 0.1, 
         10}, {$CellContext`\[Sigma]$$, 0.1, 10}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{768., {177., 182.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, Open  ]],

Cell["\<\

This section demonstrates how normalised pareto (which is a power law \
distribution) , lognormal, and exponential distributions with the same mean, \
m, and std. dev, s, vary as a function of m and s. You can use the slidey \
portion of the manipulate plot to change the values of s and m. Additionally, \
this section also shows how the relevant parameters (Pareto' s \[Alpha] and \
xmin; lognormals' s\[Sigma] and \[Mu]; exponential' s \[Lambda]) change as a \
function of s and m. Note that since the mean and the std. dev of the \
exponential distribution are the same, the first set of plots require the \
constraint that m = s. The second set of plots show pareto and lognormal \
plots without this constraint. Note that the biggest takeaway here is that \
exponential decays the fastets, while pareto decays the slowest.

   
   \
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"\[Alpha]", " ", "=", "  ", 
      FractionBox[
       RowBox[{
        SuperscriptBox["s", "2"], "+", " ", 
        SqrtBox[
         RowBox[{
          RowBox[{
           SuperscriptBox["m", "2"], 
           SuperscriptBox["s", 
            RowBox[{"2", " "}]]}], "+", " ", 
          SuperscriptBox["s", "4"]}]]}], 
       SuperscriptBox["s", "2"]]}], ";", "\[IndentingNewLine]", 
     RowBox[{"xm", " ", "=", " ", 
      FractionBox[
       RowBox[{
        SuperscriptBox["m", 
         RowBox[{"2", " "}]], "+", " ", 
        SuperscriptBox["s", "2"], " ", "-", 
        SqrtBox[
         RowBox[{
          RowBox[{
           SuperscriptBox["m", "2"], 
           SuperscriptBox["s", 
            RowBox[{"2", " "}]]}], "+", " ", 
          SuperscriptBox["s", "4"]}]], " "}], "m"]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"\[Mu]", " ", "=", " ", 
      RowBox[{"Log", "[", 
       RowBox[{"m", "/", 
        RowBox[{"Sqrt", "[", 
         RowBox[{"(", 
          RowBox[{"1", " ", "+", " ", 
           RowBox[{
            RowBox[{"(", 
             RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], ")"}], "]"}]}], 
       "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"\[Sigma]", " ", "=", " ", 
      RowBox[{"Sqrt", "[", 
       RowBox[{"Log", "[", 
        RowBox[{"(", 
         RowBox[{"1", " ", "+", " ", 
          RowBox[{
           RowBox[{"(", 
            RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], ")"}], "]"}], 
       "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"\[Lambda]", " ", "=", " ", 
      RowBox[{"1", "/", "m"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"s", " ", "=", " ", "m"}], ";", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"LogPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{
           RowBox[{"(", 
            RowBox[{
             RowBox[{"(", "\[Alpha]", ")"}], "*", 
             RowBox[{"(", 
              RowBox[{
               RowBox[{"(", "xm", ")"}], "^", 
               RowBox[{"(", "\[Alpha]", ")"}]}], ")"}]}], ")"}], "/", 
           RowBox[{"(", 
            RowBox[{"y", "^", 
             RowBox[{"(", 
              RowBox[{
               RowBox[{"(", "\[Alpha]", ")"}], "+", "1"}], ")"}]}], ")"}]}], 
          ",", 
          RowBox[{
           RowBox[{"(", 
            RowBox[{"1", "/", 
             RowBox[{"(", 
              RowBox[{"y", "*", "\[Sigma]", "*", 
               RowBox[{"Sqrt", "[", 
                RowBox[{"2", "*", "Pi"}], "]"}]}], ")"}]}], ")"}], "*", 
           RowBox[{"Exp", "[", 
            RowBox[{
             RowBox[{"-", 
              RowBox[{"(", 
               RowBox[{
                RowBox[{"(", 
                 RowBox[{
                  RowBox[{"Log", "[", "y", "]"}], "-", "\[Mu]"}], ")"}], "^", 
                "2"}], ")"}]}], "/", 
             RowBox[{"(", 
              RowBox[{"2", "*", 
               RowBox[{"\[Sigma]", "^", "2"}]}], ")"}]}], "]"}]}], ",", 
          RowBox[{"\[Lambda]", "*", 
           RowBox[{"Exp", "[", 
            RowBox[{
             RowBox[{"-", "\[Lambda]"}], "*", "y"}], "]"}]}]}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"y", ",", "0", ",", "1000"}], "}"}], ",", 
        RowBox[{"PlotLegends", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{"\"\<Pareto\>\"", ",", "\"\<Logn\>\"", ",", "\"\<Exp\>\""}],
           "}"}]}], ",", 
        RowBox[{"ImageSize", "\[Rule]", "Large"}], ",", 
        RowBox[{
        "PlotLabel", "\[Rule]", "\"\<Log-linear plot; distributions\>\""}]}], 
       "]"}], "\[IndentingNewLine]", 
      RowBox[{"Plot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"\[Alpha]", "*", 
           RowBox[{"x", "/", "x"}]}], ",", 
          RowBox[{"xm", "*", 
           RowBox[{"x", "/", "x"}]}], ",", 
          RowBox[{"\[Mu]", "*", 
           RowBox[{"x", "/", "x"}]}], ",", 
          RowBox[{"\[Lambda]", "*", 
           RowBox[{"x", "/", "x"}]}]}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"x", ",", "0.1", ",", "100"}], "}"}], ",", 
        RowBox[{"PlotLegends", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
          "\"\<alpha\>\"", ",", "\"\<xmin\>\"", ",", "\"\<mu\>\"", ",", 
           "\"\<sigma\>\"", ",", "\"\<lambda\>\""}], "}"}]}], ",", 
        RowBox[{"ImageSize", "\[Rule]", "Large"}], ",", 
        RowBox[{"PlotLabel", "\[Rule]", "\"\<Distribution parameters\>\""}]}],
        "]"}]}]}], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{"m", ",", "0.1", ",", "10"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`m$$ = 0.1, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`m$$], 0.1, 10}}, Typeset`size$$ = {
    669., {577., 184.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`m$429744$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`m$$ = 0.1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`m$$, $CellContext`m$429744$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, 
      "Body" :> ($CellContext`\[Alpha] = ($CellContext`s^2 + 
          Sqrt[$CellContext`m$$^2 $CellContext`s^2 + \
$CellContext`s^4])/$CellContext`s^2; $CellContext`xm = ($CellContext`m$$^2 + \
$CellContext`s^2 - 
          Sqrt[$CellContext`m$$^2 $CellContext`s^2 + \
$CellContext`s^4])/$CellContext`m$$; $CellContext`\[Mu] = 
        Log[$CellContext`m$$/Sqrt[
          1 + ($CellContext`s/$CellContext`m$$)^2]]; $CellContext`\[Sigma] = 
        Sqrt[
          Log[
          1 + ($CellContext`s/$CellContext`m$$)^2]]; $CellContext`\[Lambda] = 
        1/$CellContext`m$$; $CellContext`s = $CellContext`m$$; 
       LogPlot[{($CellContext`\[Alpha] \
$CellContext`xm^$CellContext`\[Alpha])/$CellContext`y^($CellContext`\[Alpha] + 
            1), (1/(($CellContext`y $CellContext`\[Sigma]) Sqrt[2 Pi])) 
           Exp[(-(Log[$CellContext`y] - $CellContext`\[Mu])^2)/(
             2 $CellContext`\[Sigma]^2)], $CellContext`\[Lambda] 
           Exp[(-$CellContext`\[Lambda]) $CellContext`y]}, {$CellContext`y, 0,
            1000}, PlotLegends -> {"Pareto", "Logn", "Exp"}, ImageSize -> 
          Large, PlotLabel -> "Log-linear plot; distributions"] 
        Plot[{$CellContext`\[Alpha] ($CellContext`x/$CellContext`x), \
$CellContext`xm ($CellContext`x/$CellContext`x), $CellContext`\[Mu] \
($CellContext`x/$CellContext`x), $CellContext`\[Lambda] \
($CellContext`x/$CellContext`x)}, {$CellContext`x, 0.1, 100}, 
          PlotLegends -> {"alpha", "xmin", "mu", "sigma", "lambda"}, 
          ImageSize -> Large, PlotLabel -> "Distribution parameters"]), 
      "Specifications" :> {{$CellContext`m$$, 0.1, 10}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{714., {422., 427.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, Open  ]],

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{
   StyleBox["%%%%%%%%%%%%%%%%%%%%%%%%%%", "Text"], "\[IndentingNewLine]", 
   StyleBox[
    RowBox[{"Below", ",", " ", 
     RowBox[{
     "I", "  ", "repeat", " ", "the", " ", "same", " ", "plots", " ", "as", 
      " ", "above"}], ",", " ", 
     RowBox[{
     "but", " ", "in", " ", "parameter", " ", "ranges", " ", "that", " ", 
      "we", " ", "observe", " ", "for", " ", "our", " ", "data"}], ",", " ", 
     RowBox[{"per", " ", "AIC", " ", "best", " ", "fit"}]}], 
    "Text"]}]}]], "Input"],

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  StyleBox[
   RowBox[{"1.", " ", "Pareto"}], "Text"]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"LogPlot", "[", 
      RowBox[{
       FormBox[
        FractionBox[
         RowBox[{"\[Alpha]", "*", 
          SuperscriptBox["xm", "\[Alpha]"]}], 
         SuperscriptBox["x", 
          RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]],
        TraditionalForm], " ", ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "xm", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"0", ",", "100"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"0", ",", "1000"}], "}"}]}], "}"}]}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Log-linear plot\>\""}]}], "]"}], 
     RowBox[{"Plot", "[", 
      RowBox[{
       FormBox[
        FractionBox[
         RowBox[{"\[Alpha]", "*", 
          SuperscriptBox["xm", "\[Alpha]"]}], 
         SuperscriptBox["x", 
          RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]],
        TraditionalForm], " ", ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "xm", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"0", ",", "4"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"0", ",", "10"}], "}"}]}], "}"}]}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Non-log plot\>\""}]}], "]"}]}], 
    ",", 
    RowBox[{"{", 
     RowBox[{"xm", ",", "0.5", ",", "1.4"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Alpha]", ",", "1.2", ",", "2"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`xm$$ = 1.4, $CellContext`\[Alpha]$$ = 1.2, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`xm$$], 0.5, 1.4}, {
      Hold[$CellContext`\[Alpha]$$], 1.2, 2}}, Typeset`size$$ = {
    723., {123., 128.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`xm$541452$$ = 
    0, $CellContext`\[Alpha]$541453$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`xm$$ = 0.5, $CellContext`\[Alpha]$$ = 1.2},
       "ControllerVariables" :> {
        Hold[$CellContext`xm$$, $CellContext`xm$541452$$, 0], 
        Hold[$CellContext`\[Alpha]$$, $CellContext`\[Alpha]$541453$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      LogPlot[$CellContext`\[Alpha]$$ \
$CellContext`xm$$^$CellContext`\[Alpha]$$/$CellContext`x^($CellContext`\
\[Alpha]$$ + 1), {$CellContext`x, $CellContext`xm$$, 100}, 
         PlotRange -> {{0, 100}, {0, 1000}}, ImageSize -> Medium, PlotLabel -> 
         "Log-linear plot"] 
       Plot[$CellContext`\[Alpha]$$ \
$CellContext`xm$$^$CellContext`\[Alpha]$$/$CellContext`x^($CellContext`\
\[Alpha]$$ + 1), {$CellContext`x, $CellContext`xm$$, 100}, 
         PlotRange -> {{0, 4}, {0, 10}}, ImageSize -> Medium, PlotLabel -> 
         "Non-log plot"], 
      "Specifications" :> {{$CellContext`xm$$, 0.5, 
         1.4}, {$CellContext`\[Alpha]$$, 1.2, 2}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{768., {181., 186.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, Open  ]],

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  StyleBox[
   RowBox[{"2.", " ", "Lognormal"}], "Text"]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"LogPlot", "[", 
      RowBox[{
       FormBox[
        RowBox[{" ", 
         FormBox[
          FractionBox[
           RowBox[{"Exp", "[", 
            FractionBox[
             RowBox[{"-", 
              SuperscriptBox[
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"Log", "[", "x", "]"}], "-", " ", "\[Mu]"}], ")"}], 
               "2"]}], 
             RowBox[{"2", "*", 
              SuperscriptBox["\[Sigma]", "2"]}]], "]"}], 
           RowBox[{"x", "*", "\[Sigma]", "*", 
            SqrtBox[
             RowBox[{"2", "*", "\[Pi]"}]]}]],
          TraditionalForm]}],
        TraditionalForm], ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "0.001", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Log-linear plot\>\""}]}], "]"}], 
     "\[IndentingNewLine]", 
     RowBox[{"Plot", "[", 
      RowBox[{
       FormBox[
        RowBox[{" ", 
         FormBox[
          FractionBox[
           RowBox[{"Exp", "[", 
            FractionBox[
             RowBox[{"-", 
              SuperscriptBox[
               RowBox[{"(", 
                RowBox[{
                 RowBox[{"Log", "[", "x", "]"}], "-", " ", "\[Mu]"}], ")"}], 
               "2"]}], 
             RowBox[{"2", "*", 
              SuperscriptBox["\[Sigma]", "2"]}]], "]"}], 
           RowBox[{"x", "*", "\[Sigma]", "*", 
            SqrtBox[
             RowBox[{"2", "*", "\[Pi]"}]]}]],
          TraditionalForm]}],
        TraditionalForm], ",", 
       RowBox[{"{", 
        RowBox[{"x", ",", "0.001", ",", "100"}], "}"}], ",", 
       RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
       RowBox[{"ImageSize", "\[Rule]", "Medium"}], ",", 
       RowBox[{"PlotLabel", "\[Rule]", "\"\<Non-log plot\>\""}]}], "]"}]}], 
    "\[IndentingNewLine]", ",", 
    RowBox[{"{", 
     RowBox[{"\[Mu]", ",", 
      RowBox[{"-", "0.4"}], ",", "4"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Sigma]", ",", "0.4", ",", "2.2"}], "}"}]}], "]"}], 
  "\[IndentingNewLine]"}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`\[Mu]$$ = 3.23, $CellContext`\[Sigma]$$ = 
    1.322, Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`\[Mu]$$], -0.4, 4}, {
      Hold[$CellContext`\[Sigma]$$], 0.4, 2.2}}, Typeset`size$$ = {
    723., {115., 120.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`\[Mu]$385106$$ = 
    0, $CellContext`\[Sigma]$385107$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`\[Mu]$$ = -0.4, $CellContext`\[Sigma]$$ = 
        0.4}, "ControllerVariables" :> {
        Hold[$CellContext`\[Mu]$$, $CellContext`\[Mu]$385106$$, 0], 
        Hold[$CellContext`\[Sigma]$$, $CellContext`\[Sigma]$385107$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      LogPlot[Exp[(-(Log[$CellContext`x] - $CellContext`\[Mu]$$)^2)/(
           2 $CellContext`\[Sigma]$$^2)]/(($CellContext`x $CellContext`\
\[Sigma]$$) Sqrt[2 Pi]), {$CellContext`x, 0.001, 100}, PlotRange -> All, 
         ImageSize -> Medium, PlotLabel -> "Log-linear plot"] 
       Plot[Exp[(-(Log[$CellContext`x] - $CellContext`\[Mu]$$)^2)/(
           2 $CellContext`\[Sigma]$$^2)]/(($CellContext`x $CellContext`\
\[Sigma]$$) Sqrt[2 Pi]), {$CellContext`x, 0.001, 100}, PlotRange -> All, 
         ImageSize -> Medium, PlotLabel -> "Non-log plot"], 
      "Specifications" :> {{$CellContext`\[Mu]$$, -0.4, 
         4}, {$CellContext`\[Sigma]$$, 0.4, 2.2}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{768., {173., 178.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, Open  ]],

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", "\[IndentingNewLine]"}]], "Input"],

Cell[BoxData["\[IndentingNewLine]"], "Input"]
},
WindowSize->{1372, 782},
WindowMargins->{{Automatic, 27}, {Automatic, 0}},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
ShowCellBracket->Automatic,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"10.4 for Mac OS X x86 (32-bit, 64-bit Kernel) (April 11, \
2016)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[1464, 33, 26, 0, 28, "Input"],
Cell[CellGroupData[{
Cell[1515, 37, 182, 4, 28, "Item"],
Cell[1700, 43, 452, 12, 41, "Item"],
Cell[2155, 57, 163, 3, 28, "Item"],
Cell[2321, 62, 98, 2, 28, "Item"],
Cell[2422, 66, 65, 0, 28, "Item"],
Cell[2490, 68, 100, 2, 28, "Item"],
Cell[2593, 72, 114, 3, 28, "Item"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2744, 80, 1555, 41, 138, "Input"],
Cell[4302, 123, 2334, 46, 370, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[6673, 174, 676, 22, 54, "Item"],
Cell[7352, 198, 240, 4, 28, "Item"],
Cell[7595, 204, 207, 4, 28, "Item"],
Cell[7805, 210, 65, 0, 28, "Item"],
Cell[7873, 212, 100, 2, 28, "Item"],
Cell[7976, 216, 92, 2, 28, "Item"]
}, Open  ]],
Cell[8083, 221, 26, 0, 28, "Input"],
Cell[CellGroupData[{
Cell[8134, 225, 2197, 62, 180, "Input"],
Cell[10334, 289, 2363, 44, 376, "Output"]
}, Open  ]],
Cell[12712, 336, 862, 16, 163, "Text"],
Cell[CellGroupData[{
Cell[13599, 356, 4669, 128, 297, "Input"],
Cell[18271, 486, 3049, 57, 866, "Output"]
}, Open  ]],
Cell[21335, 546, 557, 13, 65, "Input"],
Cell[21895, 561, 113, 3, 46, "Input"],
Cell[CellGroupData[{
Cell[22033, 568, 1758, 49, 109, "Input"],
Cell[23794, 619, 2338, 46, 384, "Output"]
}, Open  ]],
Cell[26147, 668, 116, 3, 46, "Input"],
Cell[CellGroupData[{
Cell[26288, 675, 2222, 64, 178, "Input"],
Cell[28513, 741, 2367, 44, 368, "Output"]
}, Open  ]],
Cell[30895, 788, 80, 1, 63, "Input"],
Cell[30978, 791, 45, 0, 46, "Input"]
}
]
*)

(* NotebookSignature 0vTGJHaqThaH0Cw5H2O55ohm *)

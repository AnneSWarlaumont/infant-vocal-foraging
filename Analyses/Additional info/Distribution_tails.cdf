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
NotebookDataLength[     16776,        435]
NotebookOptionsPosition[     17026,        419]
NotebookOutlinePosition[     17551,        442]
CellTagsIndexPosition[     17508,        439]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell["\<\

*This file demonstrates how normalised pareto (which is a power law \
distribution), lognormal, and exponential distributions with the same mean, m \
and standard deviation, s vary as a function of  m and s (Use the slidey \
portion
of the manipulate plot to change the values of s and m). Additionally, I also \
show how the relevant parameters (Pareto distribution's \[Alpha], and x_min; \
Lognormal's \[Sigma] and \[Mu]; exponential's \[Lambda]) change as a function \
of s and m. 
Note that since the mean and standard deviation of the exponential \
distribution are the same, the first set of plots require the constraint that \
m = s. The second set of plots show pareto and lognormal distributions \
without this constraint*\
\>", "Input", "PluginEmbeddedContent",
 FormatType->"TextForm"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"Manipulate", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"\[Alpha]", " ", "=", " ", 
       FractionBox[
        RowBox[{
         SuperscriptBox["s", "2"], "+", 
         SqrtBox[
          RowBox[{
           RowBox[{
            SuperscriptBox["m", "2"], " ", 
            SuperscriptBox["s", "2"]}], "+", 
           SuperscriptBox["s", "4"]}]]}], 
        SuperscriptBox["s", "2"]]}], ";", "\[IndentingNewLine]", 
      RowBox[{"xm", " ", "=", " ", 
       FractionBox[
        RowBox[{
         SuperscriptBox["m", "2"], "+", 
         SuperscriptBox["s", "2"], "-", 
         SqrtBox[
          RowBox[{
           SuperscriptBox["s", "2"], " ", 
           RowBox[{"(", 
            RowBox[{
             SuperscriptBox["m", "2"], "+", 
             SuperscriptBox["s", "2"]}], ")"}]}]]}], "m"]}], ";", 
      "\[IndentingNewLine]", "\[IndentingNewLine]", 
      RowBox[{"\[Mu]", " ", "=", " ", 
       RowBox[{"Log", "[", 
        RowBox[{"m", "/", 
         RowBox[{"Sqrt", "[", 
          RowBox[{"(", 
           RowBox[{"1", "+", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], ")"}], "]"}]}], 
        "]"}]}], ";", "\[IndentingNewLine]", 
      RowBox[{"\[Sigma]", " ", "=", " ", 
       RowBox[{"Sqrt", "[", 
        RowBox[{"Log", "[", 
         RowBox[{"1", " ", "+", " ", 
          RowBox[{
           RowBox[{"(", 
            RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], "]"}], "]"}]}], ";",
       "\[IndentingNewLine]", 
      RowBox[{"\[Lambda]", " ", "=", " ", 
       RowBox[{"1", "/", "m"}]}], ";", "\[IndentingNewLine]", 
      RowBox[{"s", "=", "m"}], ";", "\[IndentingNewLine]", 
      "\[IndentingNewLine]", 
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
                RowBox[{"(", "\[Alpha]", ")"}], " ", "+", " ", "1"}], ")"}]}],
              ")"}]}], ",", 
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
         "\[IndentingNewLine]", 
         RowBox[{"{", 
          RowBox[{"y", ",", "0", ",", "1000"}], "}"}], ",", 
         RowBox[{"PlotLegends", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{
           "\"\<Pareto\>\"", ",", "\"\<Logn\>\"", ",", 
            "\"\<Exponential\>\""}], "}"}]}]}], "]"}], "\[IndentingNewLine]", 
       
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
           RowBox[{"\[Sigma]", "*", 
            RowBox[{"x", "/", "x"}]}], ",", 
           RowBox[{"\[Lambda]", "*", 
            RowBox[{"x", "/", "x"}]}]}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"x", ",", "0.1", ",", "100"}], "}"}], ",", 
         RowBox[{"PlotLegends", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{
           "\"\<alpha\>\"", ",", "\"\<xmin\>\"", ",", "\"\<mu\>\"", ",", 
            "\"\<sigma\>\"", ",", "\"\<lambda\>\""}], "}"}]}]}], "]"}]}]}], 
     ",", "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"m", ",", "0.1", ",", "100"}], "}"}]}], "]"}], 
   "\[IndentingNewLine]"}]}]], "Input", "PluginEmbeddedContent"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`m$$ = 0.1, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`m$$], 0.1, 100}}, Typeset`size$$ = {
    1162., {143., 148.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`m$33738$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`m$$ = 0.1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`m$$, $CellContext`m$33738$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, 
      "Body" :> ($CellContext`\[Alpha] = ($CellContext`s^2 + 
          Sqrt[$CellContext`m$$^2 $CellContext`s^2 + \
$CellContext`s^4])/$CellContext`s^2; $CellContext`xm = ($CellContext`m$$^2 + \
$CellContext`s^2 - 
          Sqrt[$CellContext`s^2 ($CellContext`m$$^2 + \
$CellContext`s^2)])/$CellContext`m$$; $CellContext`\[Mu] = 
        Log[$CellContext`m$$/Sqrt[
          1 + ($CellContext`s/$CellContext`m$$)^2]]; $CellContext`\[Sigma] = 
        Sqrt[
          Log[
          1 + ($CellContext`s/$CellContext`m$$)^2]]; $CellContext`\[Lambda] = 
        1/$CellContext`m$$; $CellContext`s = $CellContext`m$$; 
       LogPlot[{($CellContext`\[Alpha] \
$CellContext`xm^$CellContext`\[Alpha])/$CellContext`y^($CellContext`\[Alpha] + 
            1), (1/($CellContext`y $CellContext`\[Sigma] Sqrt[2 Pi])) 
           Exp[(-(Log[$CellContext`y] - $CellContext`\[Mu])^2)/(
             2 $CellContext`\[Sigma]^2)], $CellContext`\[Lambda] 
           Exp[(-$CellContext`\[Lambda]) $CellContext`y]}, {$CellContext`y, 0,
            1000}, PlotLegends -> {"Pareto", "Logn", "Exponential"}] 
        Plot[{$CellContext`\[Alpha] ($CellContext`x/$CellContext`x), \
$CellContext`xm ($CellContext`x/$CellContext`x), $CellContext`\[Mu] \
($CellContext`x/$CellContext`x), $CellContext`\[Sigma] \
($CellContext`x/$CellContext`x), $CellContext`\[Lambda] \
($CellContext`x/$CellContext`x)}, {$CellContext`x, 0.1, 100}, 
          PlotLegends -> {"alpha", "xmin", "mu", "sigma", "lambda"}]), 
      "Specifications" :> {{$CellContext`m$$, 0.1, 100}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{1207., {201., 206.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output", "PluginEmbeddedContent"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"\[Alpha]", " ", "=", " ", 
      FractionBox[
       RowBox[{
        SuperscriptBox["s", "2"], "+", 
        SqrtBox[
         RowBox[{
          RowBox[{
           SuperscriptBox["m", "2"], " ", 
           SuperscriptBox["s", "2"]}], "+", 
          SuperscriptBox["s", "4"]}]]}], 
       SuperscriptBox["s", "2"]]}], ";", "\[IndentingNewLine]", 
     RowBox[{"xm", " ", "=", " ", 
      FractionBox[
       RowBox[{
        SuperscriptBox["m", "2"], "+", 
        SuperscriptBox["s", "2"], "-", 
        SqrtBox[
         RowBox[{
          SuperscriptBox["s", "2"], " ", 
          RowBox[{"(", 
           RowBox[{
            SuperscriptBox["m", "2"], "+", 
            SuperscriptBox["s", "2"]}], ")"}]}]]}], "m"]}], ";", 
     "\[IndentingNewLine]", "\[IndentingNewLine]", 
     RowBox[{"\[Mu]", " ", "=", " ", 
      RowBox[{"Log", "[", 
       RowBox[{"m", "/", 
        RowBox[{"Sqrt", "[", 
         RowBox[{"(", 
          RowBox[{"1", "+", 
           RowBox[{
            RowBox[{"(", 
             RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], ")"}], "]"}]}], 
       "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"\[Sigma]", " ", "=", " ", 
      RowBox[{"Sqrt", "[", 
       RowBox[{"Log", "[", 
        RowBox[{"1", " ", "+", " ", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{"s", "/", "m"}], ")"}], "^", "2"}]}], "]"}], "]"}]}], ";", 
     "\[IndentingNewLine]", "\[IndentingNewLine]", 
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
               RowBox[{"(", "\[Alpha]", ")"}], " ", "+", " ", "1"}], ")"}]}], 
            ")"}]}], ",", 
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
               RowBox[{"\[Sigma]", "^", "2"}]}], ")"}]}], "]"}]}]}], "}"}], 
        ",", "\[IndentingNewLine]", 
        RowBox[{"{", 
         RowBox[{"y", ",", "0", ",", "1000"}], "}"}], ",", 
        RowBox[{"PlotLegends", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{"\"\<Pareto\>\"", ",", "\"\<Logn\>\""}], "}"}]}]}], "]"}], 
      "\[IndentingNewLine]", 
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
          RowBox[{"\[Sigma]", "*", 
           RowBox[{"x", "/", "x"}]}]}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"x", ",", "0.1", ",", "100"}], "}"}], ",", 
        RowBox[{"PlotLegends", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
          "\"\<alpha\>\"", ",", "\"\<xmin\>\"", ",", "\"\<mu\>\"", ",", 
           "\"\<sigma\>\""}], "}"}]}]}], "]"}]}]}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{"m", ",", "0.1", ",", "100"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"s", ",", "0.1", ",", "100"}], "}"}]}], "]"}]}]], "Input", \
"PluginEmbeddedContent"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`m$$ = 49.1, $CellContext`s$$ = 
    28.300000000000004`, Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`m$$], 0.1, 100}, {
      Hold[$CellContext`s$$], 0.1, 100}}, Typeset`size$$ = {
    959., {116., 121.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`m$39365$$ = 
    0, $CellContext`s$39366$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`m$$ = 0.1, $CellContext`s$$ = 0.1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`m$$, $CellContext`m$39365$$, 0], 
        Hold[$CellContext`s$$, $CellContext`s$39366$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, 
      "Body" :> ($CellContext`\[Alpha] = ($CellContext`s$$^2 + 
          Sqrt[$CellContext`m$$^2 $CellContext`s$$^2 + \
$CellContext`s$$^4])/$CellContext`s$$^2; $CellContext`xm = \
($CellContext`m$$^2 + $CellContext`s$$^2 - 
          Sqrt[$CellContext`s$$^2 ($CellContext`m$$^2 + \
$CellContext`s$$^2)])/$CellContext`m$$; $CellContext`\[Mu] = 
        Log[$CellContext`m$$/Sqrt[
          1 + ($CellContext`s$$/$CellContext`m$$)^2]]; $CellContext`\[Sigma] = 
        Sqrt[
          Log[1 + ($CellContext`s$$/$CellContext`m$$)^2]]; 
       LogPlot[{($CellContext`\[Alpha] \
$CellContext`xm^$CellContext`\[Alpha])/$CellContext`y^($CellContext`\[Alpha] + 
            1), (1/($CellContext`y $CellContext`\[Sigma] Sqrt[2 Pi])) 
           Exp[(-(Log[$CellContext`y] - $CellContext`\[Mu])^2)/(
             2 $CellContext`\[Sigma]^2)]}, {$CellContext`y, 0, 1000}, 
          PlotLegends -> {"Pareto", "Logn"}] 
        Plot[{$CellContext`\[Alpha] ($CellContext`x/$CellContext`x), \
$CellContext`xm ($CellContext`x/$CellContext`x), $CellContext`\[Mu] \
($CellContext`x/$CellContext`x), $CellContext`\[Sigma] \
($CellContext`x/$CellContext`x)}, {$CellContext`x, 0.1, 100}, 
          PlotLegends -> {"alpha", "xmin", "mu", "sigma"}]), 
      "Specifications" :> {{$CellContext`m$$, 0.1, 100}, {$CellContext`s$$, 
         0.1, 100}}, "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{1004., {201., 206.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output", "PluginEmbeddedContent"]
}, Open  ]]
},
WindowSize->{1326.75, 1483.54},
Visible->True,
AuthoredSize->{1327, 1484},
ScrollingOptions->{"HorizontalScrollRange"->Fit,
"VerticalScrollRange"->Fit},
ShowCellBracket->False,
Deployed->True,
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
Cell[1464, 33, 807, 15, 59, "Input"],
Cell[CellGroupData[{
Cell[2296, 52, 4632, 127, 317, "Input"],
Cell[6931, 181, 2992, 56, 409, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[9960, 242, 4063, 116, 265, "Input"],
Cell[14026, 360, 2984, 56, 409, "Output"]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature 0wDhez#f5dthbD1v6UJawlZa *)

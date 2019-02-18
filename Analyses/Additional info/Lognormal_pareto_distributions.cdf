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
NotebookDataLength[      9026,        264]
NotebookOptionsPosition[      9075,        241]
NotebookOutlinePosition[      9522,        261]
CellTagsIndexPosition[      9479,        258]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[BoxData[""], "Input"],

Cell[CellGroupData[{

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
     RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]], TraditionalForm]],
  FormatType->"TraditionalForm"],
 "; \[Alpha], xm, x > 0"
}], "Item"],

Cell["\<\
We see that xm simply scales the curve while \[Alpha] affects how steeply the \
distribution decays - higher the \[Alpha], steeper the fall\
\>", "Item"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
    RowBox[{"Plot", "[", 
     RowBox[{
      FormBox[
       FractionBox[
        RowBox[{"\[Alpha]", "*", 
         SuperscriptBox["xm", "\[Alpha]"]}], 
        SuperscriptBox["x", 
         RowBox[{"\[Alpha]", " ", "+", " ", "1"}]]],
       TraditionalForm], ",", 
      RowBox[{"{", 
       RowBox[{"x", ",", "0.001", ",", "100"}], "}"}]}], "]"}], ",", 
    RowBox[{"{", 
     RowBox[{"xm", ",", "0.1", ",", "10"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Alpha]", ",", "0.1", ",", "10"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`xm$$ = 0.1, $CellContext`\[Alpha]$$ = 0.1, 
    Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`xm$$], 0.1, 10}, {
      Hold[$CellContext`\[Alpha]$$], 0.1, 10}}, Typeset`size$$ = {
    360., {105., 110.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`xm$35635$$ = 
    0, $CellContext`\[Alpha]$35636$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`xm$$ = 0.1, $CellContext`\[Alpha]$$ = 0.1},
       "ControllerVariables" :> {
        Hold[$CellContext`xm$$, $CellContext`xm$35635$$, 0], 
        Hold[$CellContext`\[Alpha]$$, $CellContext`\[Alpha]$35636$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Plot[$CellContext`\[Alpha]$$ \
$CellContext`xm$$^$CellContext`\[Alpha]$$/$CellContext`x^($CellContext`\
\[Alpha]$$ + 1), {$CellContext`x, 0.001, 100}], 
      "Specifications" :> {{$CellContext`xm$$, 0.1, 
         10}, {$CellContext`\[Alpha]$$, 0.1, 10}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{405., {163., 168.}},
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
distribution changes with \[Mu] and \[Sigma] Pareto distributions are given \
by P(x) = ",
 Cell[BoxData[
  FormBox[
   FractionBox["1", 
    RowBox[{"x\[Sigma]", 
     SqrtBox[
      RowBox[{"2", " ", "\[Pi]"}]]}]], TraditionalForm]],
  FormatType->"TraditionalForm"],
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
      SuperscriptBox["\[Sigma]", "2"]}]]], TraditionalForm]],
  FormatType->"TraditionalForm"],
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
\>", "Item"]
}, Open  ]],

Cell[BoxData[""], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"\[IndentingNewLine]", 
  RowBox[{"Manipulate", "[", 
   RowBox[{
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
       RowBox[{"x", ",", "0.001", ",", "10000"}], "}"}]}], "]"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Mu]", ",", "0.1", ",", "10"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"\[Sigma]", ",", "0.1", ",", "10"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`\[Mu]$$ = 9.39, $CellContext`\[Sigma]$$ = 
    1.4000000000000001`, Typeset`show$$ = True, Typeset`bookmarkList$$ = {}, 
    Typeset`bookmarkMode$$ = "Menu", Typeset`animator$$, Typeset`animvar$$ = 
    1, Typeset`name$$ = "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`\[Mu]$$], 0.1, 10}, {
      Hold[$CellContext`\[Sigma]$$], 0.1, 10}}, Typeset`size$$ = {
    360., {100., 104.}}, Typeset`update$$ = 0, Typeset`initDone$$, 
    Typeset`skipInitDone$$ = True, $CellContext`\[Mu]$40356$$ = 
    0, $CellContext`\[Sigma]$40357$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`\[Mu]$$ = 0.1, $CellContext`\[Sigma]$$ = 
        0.1}, "ControllerVariables" :> {
        Hold[$CellContext`\[Mu]$$, $CellContext`\[Mu]$40356$$, 0], 
        Hold[$CellContext`\[Sigma]$$, $CellContext`\[Sigma]$40357$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Plot[Exp[-(Log[$CellContext`x] - $CellContext`\[Mu]$$)^2/(
          2 $CellContext`\[Sigma]$$^2)]/($CellContext`x \
$CellContext`\[Sigma]$$ Sqrt[2 Pi]), {$CellContext`x, 0.001, 10000}], 
      "Specifications" :> {{$CellContext`\[Mu]$$, 0.1, 
         10}, {$CellContext`\[Sigma]$$, 0.1, 10}}, "Options" :> {}, 
      "DefaultOptions" :> {}],
     ImageSizeCache->{405., {158., 163.}},
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
}, Open  ]]
},
WindowSize->{641, 704},
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
Cell[1515, 37, 485, 13, 75, "Item"],
Cell[2003, 52, 163, 3, 45, "Item"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2203, 60, 617, 18, 97, "Input"],
Cell[2823, 80, 1937, 39, 348, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[4797, 124, 738, 24, 88, "Item"],
Cell[5538, 150, 240, 4, 62, "Item"],
Cell[5781, 156, 207, 4, 62, "Item"]
}, Open  ]],
Cell[6003, 163, 26, 0, 28, "Input"],
Cell[CellGroupData[{
Cell[6054, 167, 990, 30, 118, "Input"],
Cell[7047, 199, 2012, 39, 338, "Output"]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature CwTrfn5DmJUJtBK#olm@q5yv *)

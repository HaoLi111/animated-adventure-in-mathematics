using Weave

cd("D:/animated-adventure-in-mathematics/")


documentsList = ["ElementaryFnTrans"
    "ConicalCurvesNContours"
    "ParametricSurfaces"
    "RandomPts"]
documentInList = documentsList.*".jmd"
documentOutList = documentsList.*".md"
documentOutList2 = documentsList.*".html"
documentOutList3 = documentsList.*".pdf"

for i in 1:length(documentsList)
    err = []
    try
    print("Generating document:"*i)
    cd("D:/visjl/")
    weave(documentInList[1],doctype = "github",fig_path = documentInList[1])
    weave(documentInList[i],doctype = "pandoc2pdf")
    weave(documentInList[i],doctype = "pandoc2html")
    catch 
        err
    end
    print(err)
    #cd("D:/visjl/")
    #weave(i,doctype = "md2pdf")
end
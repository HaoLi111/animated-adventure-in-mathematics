using Weave

cd("D:/animated-adventure-in-mathematics/")


documentsListRaw = ["ElementaryFnTrans",
    "ConicalCurvesNContours",
    "ParametricSurfaces",
    "RandomPts",
    "TrigFnNTransformations"]
documentInList = documentsListRaw.* "/" .* documentsListRaw.*".jmd"
formats = ["github",
            "md2pdf"][1]#,
            #"pandoc2html"]

for i in 1:length(documentInList)#, j in formats
    
    
    j = "github"
    
    err = ""

    try
    print("Generating document:"*documentInList[i]*",$j \n")

    cd("D:/animated-adventure-in-mathematics/"*documentsListRaw[i])
    
    weave(documentsListRaw[i]*".jmd",doctype = j)#,fig_path = documentsList[i])
    catch 
        err
    end
    print(err)
    #cd("D:/visjl/")
    #weave(i,doctype = "md2pdf")
end
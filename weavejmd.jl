using Weave
cd("D:/visjl/")


documentsList = ["ElementaryFnTrans.jmd","ConicalCurvesNContours.jmd","ParametricSurfaces.jmd","RandomPts.jmd"]
err = []
for i in documentsList
    try
    print("Generating document:"*i)
    cd("D:/visjl/")
    weave(i)
    catch 
        err
    end
    print(err)
    #cd("D:/visjl/")
    #weave(i,doctype = "md2pdf")
end
export isHurwitz, setupEnv

using PlotThemes, Colors, Plots
using PlotThemes: expand_palette

"""
    isHurwitz(poles)

Returns true if all the elements are in the LHP, false otherwise
"""
function isHurwitz(poles::Vector)
mapreduce(i->real(i)<=0.0, &, poles)
end


ccs_palette = [
    RGB(([215, 155,   18] / 255)...), # orange
    RGB(([ 49, 103, 133] / 255)...), # sky blue
    RGB(([  0, 158, 115] / 255)...), # blueish green
    RGB(([240, 228,  66] / 255)...), # yellow
    RGB(([  0, 114, 178] / 255)...), # blue
    RGB(([213,  94,   0] / 255)...), # vermillion
    RGB(([204, 121, 167] / 255)...), # reddish purple
    ]

_ccstheme = PlotTheme(Dict([
    # colors
    :palette => expand_palette(colorant"white", ccs_palette; lchoices = [57], cchoices = [100]),
    :colorgradient => :magma,
    :bginside => RGB(([245, 246, 247] / 255)...),
    :background => RGB(([239, 239, 239] / 255)...),
    # grid
    :grid => true,
    :gridalpha => 0.4,
    :linewidth => 1.4,
    :minorgrid => true,
    :framestyle => :semi,
    :markeralpha => 0.9,
    :gridlinewidth => 0.7,
    # fonts
    :legend => (90,:outer),
    :fontfamily => "BerkeleyMono-Regular",
    :yguidefontsize	 => 8,
    :ytickfontsize => 5,
    :thickness_scaling => 1,
    :ywiden => true,
    :markerstrokewidth => 1,
    :markerstrokealpha => 1,
    :markerstrokecolor => :black,
    :markerstrokestyle => :solid])
)

function setupEnv()
    # detects REPL vs Quarto execution
    if isfile("quarto.yml")
        ENV["GKS_FONT_DIRS"] = joinpath(pwd(),"_3rdparty","fonts","BKM")
    else
         ENV["GKS_FONT_DIRS"] = joinpath(pwd(),"docs", "_3rdparty","fonts","BKM")
    end
    add_theme(:ccs, _ccstheme)
    theme(:ccs)
end

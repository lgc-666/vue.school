/**
 * Created by CastingJ on 17/5/12.
 * html版
 */

function CoordTransformer()
{
    var _oriOrigion;
    var _oriAxisX;
    var _oriAxisY;
    var _oriRange;

    var _tarOrigion;
    var _tarAxisX;
    var _tarAxisY;
    var _tarRange;

    this.getVectorLen = function(vector)
    {
        return Math.sqrt(vector.x*vector.x + vector.y*vector.y);
    }

    this.init = function(origonParas,targetParas)
    {
        if(origonParas.length!=3 || targetParas.length != 3)
            return false;

        _oriOrigion = origonParas[0];//原始坐标原点
        _oriAxisX = {'x':origonParas[1].x - origonParas[0].x ,'y':origonParas[1].y - origonParas[0].y};//原始坐标系X轴向量
        _oriAxisY = {'x':origonParas[2].x - origonParas[0].x ,'y':origonParas[2].y - origonParas[0].y};//原始坐标系Y轴向量
        _oriRange = {'x':this.getVectorLen(_oriAxisX),'y':this.getVectorLen(_oriAxisY)};//原始坐标系XY轴长度(模)

        _tarOrigion = targetParas[0];//目标坐标原点
        _tarAxisX = {'x':targetParas[1].x - targetParas[0].x ,'y':targetParas[1].y - targetParas[0].y};//原始坐标系X轴向量
        _tarAxisY = {'x':targetParas[2].x - targetParas[0].x ,'y':targetParas[2].y - targetParas[0].y};//原始坐标系X轴向量
        _tarRange = {'x':this.getVectorLen(_tarAxisX),'y':this.getVectorLen(_tarAxisY)};//原始坐标系X轴向量

        //向量单位化
        _oriAxisX.x /= _oriRange.x; _oriAxisX.y /= _oriRange.x;
        _oriAxisY.x /= _oriRange.y; _oriAxisY.y /= _oriRange.y;

        _tarAxisX.x /= _tarRange.x; _tarAxisX.y /= _tarRange.x;
        _tarAxisY.x /= _tarRange.y; _tarAxisY.y /= _tarRange.y;
    };

    this.transform = function(origon)
    {
        var offset = {'x':origon.x-_oriOrigion.x,'y':origon.y-_oriOrigion.y};
        var offsetX = _oriAxisX.x*offset.x + _oriAxisX.y*offset.y;
        var offsetY = _oriAxisY.x*offset.x + _oriAxisY.y*offset.y;
        var offstRatio = {'x':offsetX/_oriRange.x,'y':offsetY/_oriRange.y};

        var tarOffset = {'x':offstRatio.x*_tarRange.x,'y':offstRatio.y*_tarRange.y};
        var tarCoord = {'x':_tarOrigion.x+_tarAxisX.x*tarOffset.x+_tarAxisY.x*tarOffset.y,'y':_tarOrigion.y+_tarAxisX.y*tarOffset.x+_tarAxisY.y*tarOffset.y};

        return tarCoord;
    };

}
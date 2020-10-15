let _oriOrigion;
let _oriAxisX;
let _oriAxisY;
let _oriRange;

let _tarOrigion;
let _tarAxisX;
let _tarAxisY;
let _tarRange;


let getVectorLen =(vector) => {
    return Math.sqrt(vector.x*vector.x + vector.y*vector.y);
}

let init =(origonParas,targetParas)=>{
    _oriOrigion = origonParas[0];//原始坐标原点
    _oriAxisX = {'x':origonParas[1].x - origonParas[0].x ,'y':origonParas[1].y - origonParas[0].y};//原始坐标系X轴向量
    _oriAxisY = {'x':origonParas[2].x - origonParas[0].x ,'y':origonParas[2].y - origonParas[0].y};//原始坐标系Y轴向量
    _oriRange = {'x':getVectorLen(_oriAxisX),'y':getVectorLen(_oriAxisY)};//原始坐标系XY轴长度(模)

    _tarOrigion = targetParas[0];//目标坐标原点
    _tarAxisX = {'x':targetParas[1].x - targetParas[0].x ,'y':targetParas[1].y - targetParas[0].y};//原始坐标系X轴向量
    _tarAxisY = {'x':targetParas[2].x - targetParas[0].x ,'y':targetParas[2].y - targetParas[0].y};//原始坐标系X轴向量
    _tarRange = {'x':getVectorLen(_tarAxisX),'y':getVectorLen(_tarAxisY)};//原始坐标系X轴向量

    //向量单位化
    _oriAxisX.x /= _oriRange.x; _oriAxisX.y /= _oriRange.x;
    _oriAxisY.x /= _oriRange.y; _oriAxisY.y /= _oriRange.y;

    _tarAxisX.x /= _tarRange.x; _tarAxisX.y /= _tarRange.x;
    _tarAxisY.x /= _tarRange.y; _tarAxisY.y /= _tarRange.y;
}

export const transform=(origonParas,targetParas,orix,oriy)=>{
    init(origonParas,targetParas);
    let offset = {'x':orix-_oriOrigion.x,'y':oriy-_oriOrigion.y};
    let offsetX = _oriAxisX.x*offset.x + _oriAxisX.y*offset.y;
    let offsetY = _oriAxisY.x*offset.x + _oriAxisY.y*offset.y;
    let offstRatio = {'x':offsetX/_oriRange.x,'y':offsetY/_oriRange.y};

    let tarOffset = {'x':offstRatio.x*_tarRange.x,'y':offstRatio.y*_tarRange.y};
    let tarCoord = {'x':_tarOrigion.x+_tarAxisX.x*tarOffset.x+_tarAxisY.x*tarOffset.y,'y':_tarOrigion.y+_tarAxisX.y*tarOffset.x+_tarAxisY.y*tarOffset.y};

    return tarCoord;
}


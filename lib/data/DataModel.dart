class KlineModel {
  
  String status;
  List<Kline> ticker;

  KlineModel(this.status, this.ticker);
  
  KlineModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    (json[''] as List).map((i)=> )
    
  }
  

  /*Kline(this.symbol, this.last, this.buy, this.sell, this.high, this.low,
      this.vol, this.change);*/
}

class Kline{
  String? symbol;
  String? last;
  String? buy;
  String? sell;
  String? high;
  String? low;
  String? vol;
  String? change;
  
  
}

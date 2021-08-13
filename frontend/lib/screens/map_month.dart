// Converts the month number into the month word
// e.g. '01' -> 'JAN'
String mapMonth(String month){
  if(month == '01'){
    return 'JAN';
  }
  else if(month == '02'){
    return 'FEB';
  }
  else if(month == '03'){
    return 'MAR';
  }
  else if(month == '04'){
    return 'APR';
  }
  else if(month == '05'){
    return 'MAY';
  }
  else if(month == '06'){
    return 'JUN';
  }
  else if(month == '07'){
    return 'JUL';
  }
  else if(month == '08'){
    return 'AUG';
  }
  else if(month == '09'){
    return 'SEP';
  }
  else if(month == '10'){
    return 'OCT';
  }
  else if(month == '11'){
    return 'NOV';
  }
  else if(month == '12'){
    return 'DEC';
  }
  else return month;
}
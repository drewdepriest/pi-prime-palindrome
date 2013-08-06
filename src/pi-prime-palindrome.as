import flash.events.Event;

//remote text file that stores the first 100,000 digits of pi
//var reqURL = "http://www.angio.net/pi/digits/100000.txt";
var reqURL = “http://www.drewdepriest.com/100000.txt”;

//remote text file that stores the first 1,000,000 digits of pi
//var reqURL = "http://www.piday.org/includes/pi_to_1million_digits_v2.html";

//Simple request to load in remote text file
var loadReq:URLLoader = new URLLoader();
loadReq.addEventListener(Event.COMPLETE, onComplete);
loadReq.load(new URLRequest(reqURL));
	
//parse the response and build the dynamic text
function onComplete (event:Event):void
{	
	var piString:String = new String(event.target.data);
	
	//*********************************************************************
	// If using the 1M digits page, strip out the unnecessary chars first
	//*********************************************************************
	//piString = piString.substring(piString.indexOf("/>")+2,piString.length);
	//piString = piString.substring(0,piString.indexOf("</p>"));
	//piString.replace(/\s+/g, '');
	//trace(piString);
	
	//build array of 7-digit substrings of the digits of pi
	var sevens:Array = new Array();
	var i;
	var palindromes:Array = new Array();
	var places:Array = new Array();
	var j=0;
	for(i=0;i<(piString.length);i++)
	{
		sevens[i] = piString.substring(i,i+7);
		//trace(sevens[i]);
		
		//palindrome check		
		if((sevens[i].charAt(0) == sevens[i].charAt(6)) && (sevens[i].charAt(1) == sevens[i].charAt(5)) && (sevens[i].charAt(2) == sevens[i].charAt(4)))
		{
			palindromes[j] = sevens[i];
			places[j] = i;
			j++;
		}//CLOSE palindrome check

	}//CLOSE i for-loop
	//trace("There are " + palindromes.length + " palindromes in the first 100,000 digits of Pi.");

	//prime check
	var tempNum:Number = new Number();
	
	var k;
	var l;
	for(k=0;k<palindromes.length;k++)
	{
		var prime=true;
		for(l=2;l<(palindromes[k]/2);l++)
		{
			if(palindromes[k]%l == 0)
			{
				prime=false;
				break;
			} //CLOSE if(palindrome prime check)
			
		} //CLOSE l for-loop

		if(prime)
		{
			var tempStr01:String = new String(k);
			var tempStr02:String = new String(places[k]-1);
			var suffix01:String = new String();
			var suffix02;
			
			//identify the least significant digit of the value of k
			//then add the appropriate suffix			
			if(tempStr01.charAt(tempStr01.length-1) == "1"){suffix01 = "ST";}
			else if(tempStr01.charAt(tempStr01.length-1) == "2"){suffix01 = "ND";}
			else if(tempStr01.charAt(tempStr01.length-1) == "3"){suffix01 = "RD";}
			else{suffix01 = "TH";}
			
			//do the same thing for the second block of text
			if(tempStr02.charAt(tempStr02.length-1) == "1"){suffix02 = "ST";}
			else if(tempStr02.charAt(tempStr02.length-1) == "2"){suffix02 = "ND";}
			else if(tempStr02.charAt(tempStr02.length-1) == "3"){suffix02 = "RD";}
			else{suffix02 = "TH";}
			
			line01.text = "THE " + k + suffix01 + " STRING OF 7-DIGIT PALINDROMES, " + palindromes[k] + ", IS PRIME.";
			line02.text = "THE FIRST DIGIT OF THIS STRING IS THE " + (places[k]-1) + suffix02 + " DIGIT OF PI.";
			line03.text = "SUCCESS."
			break;
		} //CLOSE if-prime
		
	} //CLOSE k for-loop
	
} //CLOSE onComplete function

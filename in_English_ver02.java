package project_may;
public class Blackjack_210520 {
	public static java.util.Scanner sc=new java.util.Scanner(System.in);	
	public static int deck[] = new int[52]; //카드 전체 묶음
	public static int p1Deck[] = new int[13];
	public static int p2Deck[] = new int[13];
	public static int deckIndex=52;
	public static int p1DeckIndex=0;
	public static int p2DeckIndex=0;
	public static boolean isP1EndFlag=false;
	public static boolean isP2EndFlag=false;
	public static final String CARD_SHAPE[] = {
			"SPD","DIA","HRT","CLV"}; //상수로 처리
	public static final String CARD_NUMBER[] = {
			"A","2","3","4","5","6","7","8","9","10","J","Q","K"}; //상수로 처리
	public static void newCard() {
		for (int i=0;i<deck.length;i++) {
			deck[i]=i;
		}
		deckIndex=52; p1DeckIndex=0; p2DeckIndex=0;
		System.out.println("We guarantee using a new set of cards.\nPlayers are free to check the whole cards.");
	}
	public static void mixCard() {
		System.out.println("Dealer is mixing the deck.\nPlease wait a moment.\n");
		for(int i=0;i<10000;i++) {
			int randomIndex=(int)(Math.random()*52);
			int temp=deck[0];
			deck[0]=deck[randomIndex];
			deck[randomIndex]=temp;
		}
	}

	public static void displayTotalDeck() {
		System.out.println("Displaying total deck...");
		for(int i=0;i<deck.length;i++) {
			System.out.print(CARD_SHAPE[deck[i]/13]+" "+CARD_NUMBER[deck[i]%13]+"  ");
			
		}
		System.out.println("\n");
	}
//	public static void displayUsingDeck() {
//		System.out.println("\ndisplayUsingDeck()...");
//		for(int i=deckIndex;i<deck.length;i++) {
//			System.out.print(CARD_SHAPE[deck[i]/13]+" "+CARD_NUMBER[deck[i]%13]+"  ");
//		}
//		System.out.println();
//	}
	public static void displayNoUsingDeck() {
		System.out.println("Displaying Initial Deck...");
		for(int i=0;i<deckIndex;i++) {
			System.out.print(CARD_SHAPE[deck[i]/13]+" "+CARD_NUMBER[deck[i]%13]+"  ");
			if(CARD_NUMBER[deck[i]%13]=="K") {
				System.out.print("\n");
			}
		}
		System.out.print("\n");
	}	
	public static void displayP1Deck() {
		System.out.print("P1 : ");
		for(int i=0;i<p1DeckIndex;i++) {
			System.out.print(CARD_SHAPE[p1Deck[i]/13]+" "+CARD_NUMBER[p1Deck[i]%13]+"  ");					
		}
		System.out.println();
	}
	public static void displayP2Deck() {
		System.out.print("P2 : ");
		for(int i=0;i<p2DeckIndex;i++) {
			System.out.print(CARD_SHAPE[p2Deck[i]/13]+" "+CARD_NUMBER[p2Deck[i]%13]+"  ");					
		}
		System.out.println();
	}
	public static void getP1Card() {
		p1Deck[p1DeckIndex]=deck[deckIndex-1];
		deckIndex--;
		p1DeckIndex++;
	}
	public static void getP2Card() {
		p2Deck[p2DeckIndex]=deck[deckIndex-1];
		deckIndex--;
		p2DeckIndex++;
	}
	
	public static int p1Score() {
		int returnValue = 0;
		for(int i=0;i<p1DeckIndex;i++) {
			int cardScore=p1Deck[i]%13 +1;
			if (cardScore>10){
				cardScore=10;
			}
			returnValue = returnValue+cardScore;
		}
		for(int i=0;i<p1DeckIndex;i++) {
			if(p1Deck[i]%13==0) {
				if(returnValue+10>21) {
				}else {
					returnValue=returnValue+10;
				}
			}
		}
		return returnValue;
	}	
	public static int p2Score() {
		int returnValue = 0;
		for(int i=0;i<p2DeckIndex;i++) {
			int cardScore=p2Deck[i]%13 +1;
			if (cardScore>10){
				cardScore=10;
			}
			returnValue = returnValue+cardScore;
		}
		for(int i=0;i<p2DeckIndex;i++) {
			if(p2Deck[i]%13==0) {
				if(returnValue+10>21) {
				}else {
					returnValue=returnValue+10;
				}
			}
		}
		return returnValue;
	}
	
	public static void newGame() {
		isP1EndFlag=false;
		isP2EndFlag=false;
		System.out.println("A new game is about to start.\nPlayers need to ready.\n");
	}
	public static void playCardGame() {
		System.out.println("-----------------------------");
		System.out.println("      Let's Start Game!");
		System.out.println("-----------------------------");
		System.out.println();
		while (!(isP1EndFlag&&isP2EndFlag)) {
			if(!isP1EndFlag) {
				System.out.println("P1, are you going to get another card? 1.yes 2.no");
				if("1".equals(sc.nextLine())) {
					getP1Card();
					displayP1Deck();
					if(p1Score()>21) {
						System.out.println("P1's score is over 21. Game Over!");
						isP1EndFlag=true;						
						isP2EndFlag=true;						
					}
				}else {
					isP1EndFlag=true;
				}
			}
			if(!isP2EndFlag) {
				System.out.println("P2, are you going to get another card? 1.yes 2.no");
				if("1".equals(sc.nextLine())) {
					getP2Card();
					displayP2Deck();
					if(p2Score()>21) {
						System.out.println("P2's score is over 21. Game Over!");
						isP1EndFlag=true;						
						isP2EndFlag=true;						
					}
				}else {
					isP2EndFlag=true;
				}
			}
			System.out.println("\nFor This Round");
			System.out.println("P1's total score: "+p1Score());
			System.out.println("P2's total score: "+p2Score());
			System.out.println("------------------------- \n");
		}
	}
	public static void endGame() {
		String result="";
		if(p1Score()>21) {
			result="P2 WIN!";
		}else if(p2Score()>21) {
			result="P1 WIN!";
		}else if(p1Score()>p2Score()) {
			result="P1 WIN!";
		}else if(p1Score()<p2Score()) {
			result="P2 WIN!";
		}else {
			result="DRAW!";
		}
		System.out.println(result);
		System.out.println("Thank you for playing!");

	}

	//main/////////////////////////////////////////////////
	
	public static void main(String[] args) {
		newGame();
		
		newCard();
		displayNoUsingDeck();
		mixCard();
		
		playCardGame();
		endGame();
	
	} //public static void main(String[] args)
} //public class Blackjack_210520

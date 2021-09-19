/* 트럼프 카드를 이용한 블랙잭 게임
 * A 2 ~ 10 J(10) Q(10) K(10) 인물카드를 11,12,13으로 적용하지 않는다.
 *Ace는 player의 선택으로 1과 10 중에 선택하여 합을 구할 수 있다.  
 *스페이드Spd 하트Hrt 다이아몬드Dia 클로버Clb 문양 간의 우위는 없다.
 *두 명의 player가 번갈아가며 임의의 카드를 하나씩 받는다.
 *숫자의 합이 21에 가까우면 이긴다. 단 21을 넘으면 무조건 진다. 
 *카드를 그만 받고 싶으면 그만 받을 수 있다. 한명은 그만받고 다른 한명만 더 받을 수도 있다. */

public class BlackJack_2 {
	public static void main(String[] args) {
		
		//정리가 잘 된 트럼프카드 배열 생성. 카드마다 번호(인덱스)를 부여한다. 스페이드A부터 클로버K까지 0~51로 부여한다.
		int deck[] = new int[13*4];
		for(int i=0;i<deck.length;i++) {
			deck[i] = i;   
		}		
		
		// 컴퓨터는 0~51까지 인식가능하지만 사용자에게는 원래 의미인 스페이드A~클로버K로 보여주어야한다. 13을 기준으로 %,/를 수행하면 된다.
		String cardShape[] = {"스페이드","하트","다이아","클로버"};
		String cardNumber[] = {"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
		
		
		//컴퓨터에 배열의 형태로 저장된 트럼프 카드는 현실 상의 카드에 아래와 같이 대응된다.
		// deck[0~12]: Spd A, 2~10, J, Q, K 
		// deck[13~25]= Hrt A~K, deck[26~38]=Dia A~K, [39~51] = Clb A~K
		// 예를 들어, deck배열의 스물세번째 인덱스 deck[22]는 "하트 10" 카드에 대응한다.
		
		// 사용자에게 deck[i] 카드를 출력할 때는 다음과 같은 형식의 코드로 작성될 것이다.
		// System.out.println(cardShape[deck[i]/13]+" "+cardNumber[deck[i]%13])
		
		
		//순서정리가 되어있는 트럼프 카드로 게임을 할 수는 없으므로 트럼프 카드를 섞는다.
		//랜덤한 한장을 뽑아서 0번째 카드와 바꾼다. 또다른 랜덤한 한장을 뽑아서 새로운 0번째 카드와 바꾼다.
		for(int i=0;i<10000;i++) { 
			int temp=0;
			int random = (int)(Math.random()*52); 
			temp = deck[random] ;  
			deck[random] = deck[0]; 
			deck[0] = temp;
		}

		//필요한 변수 선언부.
		//플레이어 2명을 기준으로, 플레이어 수를 조정하면 해당 사람수만큼 반복문을 설정해 변수명과 카드배분 작업을 반복하면 된다.
		String playerA; //선공
		String playerZ; //후공	
		int pADeck[] = new int[12];  
		int pZDeck[] = new int[12];
		/*매우 희박한 확률로 A 4장, 2 4장, 3 3장을 한 플레이어가 모두 받으면 11장의 카드를 받고도 합21로 승리할 수 있다. 
		 * 다만 이때 12번째 카드를 받을지 선택할 수 있도록 12개의 인덱스를 가지는 배열로 설정하고, 
		 * 12번째 카드를 받게 되면 합이 21이 초과해 무조건 패배하게 될 것이다. 
		 * 따라서 12번째 인덱스가 없으면 오류가 발생할 위험이 있지만 13번째 자리는 필요하지 않다.*/
		int deckIndex = 0;
		int pADeckIndex = 0;
		int pZDeckIndex = 0;
		boolean pAGameEndFlag = true;
		boolean pZGameEndFlag = true;
		int sumA = 0;
		int sumZ = 0;
		
		System.out.println(">>BlackJack 게임에 오신 것을 환영합니다!<<");
		System.out.println();
		
		//개인화된 경험을 위해 닉네임을 설정하고, 입력하지 않을 경우 디폴트값으로 진행한다.
		System.out.println("player1님, 닉네임을 설정해주세요!");
		String p1name = new java.util.Scanner(System.in).nextLine();
		if (p1name.equals("")) {
			p1name = "player1";
		}
		System.out.println(p1name+"(으)로 입장합니다!");
		System.out.println();
		
		System.out.println("player2님, 닉네임을 설정해주세요!");
		String p2name = new java.util.Scanner(System.in).nextLine();
		if (p2name.equals("")) {
			p2name = "player2";
		}
		System.out.println(p2name+"(으)로 입장합니다!");
		System.out.println();

		System.out.println(">>1:1 테이블에 입장하였습니다!<<");
		System.out.println();

		//선공에게 불리한 룰이 될 수 있으므로 선-후공을 랜덤으로 결정한다.
		System.out.println(">>동전던지기로 선턴을 결정합니다!<<");
		System.out.println(">>앞면이 나오면 "+p1name+"님이 선턴, 뒷면이 나오면 "+p2name+"님이 선턴으로 시작합니다!<<");
		
		int coin = (int)(Math.random()*2);
		if(coin==0) {
			System.out.println(">>앞면이 나왔습니다! "+p1name+"님이 먼저 시작합니다!<<");
			playerA = p1name;
			playerZ = p2name;
		}else { //coin==1) 
			System.out.println(">>뒷면이 나왔습니다! "+p2name+"님이 먼저 시작합니다!<<");
			playerA = p2name;
			playerZ = p1name;	
		}
		
		System.out.println();
		System.out.println(">>게임을 시작하겠습니다!<<");
		System.out.println();
		System.out.println(">>카드를 섞는 중입니다..<<");
		System.out.println();

		//아래 for문은 최종 결과값 출력 직전까지 계속됩니다... 
		for(int j=0;j<12;j++) { 
			System.out.println(j+1+"번째 턴");
			
			//선공이 카드를 받을 것인가? 받는다면 다음 턴 반복문을 반복하면서 줄 것이고 안받는다면 pAGameEndFlag가 false로 바뀐다.
			if(pAGameEndFlag) {
				System.out.println(playerA+"님, 카드를 받으시겠습니까? 1.받음 2.안받음");
				String inputA = new java.util.Scanner(System.in).nextLine();
				if(inputA.equals("1")) {
					pADeck[pADeckIndex++] = deck[deckIndex++];				
				}else {
					pAGameEndFlag = false;	
				}
			}
			
			//후공이 카드를 받을 것인가? 안받는다면 pZGameEndFlag가 false로 바뀐다.
			if(pZGameEndFlag) {
				System.out.println(playerZ+"님, 카드를 받으시겠습니까? 1.받음 2.안받음");
				String inputZ = new java.util.Scanner(System.in).nextLine();
				if(inputZ.equals("1")) {
					pZDeck[pZDeckIndex++] = deck[deckIndex++];	
				}else {
					pZGameEndFlag = false;	
				}
			}
			
			//선공이 가진 모든 카드 출력하기
			System.out.print("  "+playerA+"님의 현재 카드: ");
			for(int i=0;i<pADeckIndex;i++) {
				System.out.print(cardShape[pADeck[i]/13]+" "+cardNumber[pADeck[i]%13]+". ");
			}
			
			//선공의 현재까지의 모든 카드의 총합 계산하기
			sumA = 0; //sum을 다시 0으로 설정하지 않으면 이전 turn에서 저장된 sum에 다시 더하게 되므로 전체 반복문이 반복되는 것을 고려해 0으로 초기화하고 작은 반복문을 수행한다.
			for(int i=0;i<pADeckIndex;i++) {
				//컴퓨터는 0~51로 인식하므로, 사전에 정한 방식으로 카드의 현실 번호를 sum에 더하기
				switch(pADeck[i]%13) {
				case 0: //Ace 
				case 10: //Jack
				case 11: //Queen
				case 12: //King
					sumA = sumA + 10;
					break;
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
					sumA = sumA + (pADeck[i]%13) +1; //쓰여진 값을 그대로 더하되, 배열의 인덱스는 0부터 시작하였으므로 +1을 해야한다.
					break;
				}
			}		
			
			//ACE는 기본적으로 10으로 하되, 합이 21이 넘었을 경우 +10-9하여 1을 더한 것으로 추가처리한다.
			if(sumA>21) { //만약 해당 턴에서 합이 21을 초과할 경우 패배할 위험이 존재한다.
				for(int i=0;i<pADeckIndex;i++) { //현재 가진 카드를 모두 조회하면서,
					if(pADeck[i]%13==0) { //Ace카드가 있다면,
						sumA = sumA-9; //Ace를 10이 아닌 1로 처리하기 위하여 기존 10을 더한 값에서 9를 뺀다.
						if(sumA<21) { //1번의 작업으로 위험이 해소되었을 경우 작업을 종료하고, 아닐 경우 다음 카드를 조회하여 Ace가 있는지 계속 탐색한다. 
							break;
						}
					}
				}
			}
		
			//선공의 현재 총합 출력하기
			System.out.println("\n  "+playerA+"님의 현재 총합: "+sumA);
			System.out.println();
			
			//후공인 playerZ의 덱에 대한 계산도 위와 동일한 코드로 수행한다. 
			
			//후공이 가진 모든 카드 출력하기
			System.out.print("  "+playerZ+"님의 현재 카드: ");
			for(int i=0;i<pZDeckIndex;i++) {
				System.out.print(cardShape[pZDeck[i]/13]+" "+cardNumber[pZDeck[i]%13]+". ");
			}
			
			//후공의 현재까지의 모든 카드의 총합 계산하기
			sumZ = 0;
			for(int i=0;i<pZDeckIndex;i++) {
				switch(pZDeck[i]%13) {
				case 0:		case 10: 
				case 11:	case 12:
					sumZ = sumZ + 10;
					break;
				case 1:	case 2:	case 3:
				case 4:	case 5:	case 6:
				case 7:	case 8:	case 9:
					sumZ = sumZ + (pZDeck[i]%13) +1;
					break;
				}
			}
			
			if(sumZ>21) {
				for(int i=0;i<pZDeckIndex;i++) {
					if(pZDeck[i]%13==0) {
						sumZ = sumZ-9;
						if(sumZ<21) {
							break;
						}
					}
				}
			}
			
			//후공의 현재 총합 출력하기
			System.out.println("\n  "+playerZ+"님의 현재 총합: "+sumZ);
			System.out.println();
			
			//playerA의 sumA가 21을 넘을 경우 playerZ와 관계없이 무조건 카드분배를 종료한다. 
			//조건식을 만족하지 않을 경우 수행하지 않는다.
			//만약 해당 턴에서 sumZ도 21을 넘게 될 경우라도, 21을 먼저 초과한 사람이 먼저 지게 되므로 원래 선공이 좀 불리하다.
			if(sumA>21) {
				pAGameEndFlag=false;
				pZGameEndFlag=false; //playerZ가 true를 선택했더라도 카드분배를 강제종료한다.
				System.out.println(">>"+playerA+"님의 총합이 21을 초과합니다!<<");
				System.out.println();
			}else if(sumZ>21) { 		//playerZ의 sumZ만 21을 넘을 경우에도 카드분배를 종료한다.
				pAGameEndFlag=false;
				pZGameEndFlag=false;
				System.out.println(">>"+playerZ+"님의 총합이 21을 초과합니다!<<");
				System.out.println();
			}
			
			//191~193 해당 턴의 결과 pAGameEndFlag와 pZGameEndFlag가 모두 false일 때는 다음 턴을 진행하지 않고 빠져나간다.
			if(pAGameEndFlag==false&&pZGameEndFlag==false) {
				System.out.println(">>카드분배를 종료합니다!<<");
				System.out.println();
				break;
			}
			
		} //게임을 시작할 때 열린 for문이 닫힌다.

		//최종 결과와 승패 출력하기 
		System.out.println(playerA+"님의 최종 총합: "+sumA);
		System.out.println(playerZ+"님의 최종 총합: "+sumZ);
		System.out.println();
		
		if(sumA>21) { // 합이 21이 넘으면 선공이 패배로 먼저 판정된다.
			System.out.println(playerZ+"님이 승리하였습니다!");
		}else if(sumZ>21) { // sumA가 21이하이면서 sumZ만 21을 넘었으면 playerA가 승리한다.
			System.out.println(playerA+"님이 승리하였습니다!");
		}else if(sumA==sumZ) {
			System.out.println("비겼습니다!");
		}else if(sumA>sumZ) { // 두 player 모두 합이 21이 넘지 않을 경우 sum이 더 큰 사람이 21에 더 가까운 것이므로 그 값을 비교하여 승패를 출력한다.
			System.out.println(playerA+"님이 승리하였습니다!");
		}else {
			System.out.println(playerZ+"님이 승리하였습니다!");
		}
		System.out.println();
		
		//블랙잭 게임 종료
		System.out.println(">>플레이해주셔서 감사합니다!<<");
	}
}

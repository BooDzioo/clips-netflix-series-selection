package put.ai.games.myplayer;

import put.ai.games.game.Board;
import put.ai.games.game.Move;
import put.ai.games.game.Player;

import java.util.List;
import java.util.Random;

public class MyPlayer extends Player {

    private Random random = new Random(0xdeadbeef);

    public static void main(String[] args) {}

    @Override
    public String getName() {
        return "Mikolaj Napierala 151812 Hubert Bogdanski 151751";
    }

    @Override
    public Move nextMove(Board board) {
        long startTime = System.currentTimeMillis();
        long endTime = startTime + (getTime()*(long)0.9);//;
        List<Move> moves = board.getMovesFor(getColor());
        Move bestMove = null;
        int maxScore = Integer.MIN_VALUE;

        for (Move move : moves) {
        	//System.out.println("Typ ruchu: " + move.getClass().getSimpleName() + "info: " + move.toString() + "time:" + getTime());
        	
            Board tempBoard = board.clone();
            tempBoard.doMove(move);

            int score = minMax(tempBoard, 4, Integer.MIN_VALUE, Integer.MAX_VALUE, false, endTime);
            if (score > maxScore) {
                maxScore = score;
                bestMove = move;
                System.out.println("Typ ruchu: " + move.getClass().getSimpleName() + "info: " + move.toString() + "time:" + getTime()+ " score: " + score);
            }
        }
        
        System.out.println("Typ ruchu: " + bestMove.getClass().getSimpleName() + "info: " + bestMove.toString() + "time:" + getTime()+ " maxScore: " + maxScore);
        return bestMove;
    }

    private int minMax(Board board, int depth, int alpha, int beta, boolean maximizingPlayer, long endTime) {
        if (System.currentTimeMillis() >= endTime || depth == 0 || board.getWinner(getColor()) != null) {
            return evaluate(board);
        }

        List<Move> moves = board.getMovesFor(maximizingPlayer ? getColor() : getOpponent(getColor()));
        int bestValue = maximizingPlayer ? Integer.MIN_VALUE : Integer.MAX_VALUE;

        for (Move move : moves) {
            Board tempBoard = board.clone();
            tempBoard.doMove(move);
            last_move = move;
            int value = minMax(tempBoard, depth - 1, alpha, beta, !maximizingPlayer, endTime);

            if (maximizingPlayer) {
                bestValue = Math.max(bestValue, value);
                alpha = Math.max(alpha, bestValue);
            } else {
                bestValue = Math.min(bestValue, value);
                beta = Math.min(beta, bestValue);
            }

            if (beta <= alpha) {
                break;
            }
        }

        return bestValue;
    }

    private int evaluate(Board board) {
        int score = 0;

        
        for (int row = 0; row < board.getSize(); row++) {
            for (int col = 0; col < board.getSize(); col++) {
                if (board.getState(row, col) == getColor()) {
                	int actualHorizontalScore = countAdjacentStones(board, row, col, true);
                    
                    if(actualHorizontalScore != -1)
                    	score += actualHorizontalScore;
                    
                    
                    int actualVerticalScore = countAdjacentStones(board, row, col, false);
                    if(actualVerticalScore != -1)
                    	score += actualVerticalScore;

                }
            }
        }

        return score;
    }

    
    private int SCORE_4_STRIKE = 1000;
    private int SCORE_3_STRIKE = 100;
    private int SCORE_2_STRIKE = 10;
    private Move last_move;
    
    private int countAdjacentStones(Board board, int row, int col, boolean horizontal) {
        int count = 0;
        Player.Color playerColor = getColor();
        
        Player.Color enemyColor = getOpponent(getColor());

        int enemyCount = 0;
        int strike = 0;
        
        if(horizontal) {
             for (int iterCol = 0; iterCol < board.getSize(); iterCol++) {
                 if (board.getState(row, iterCol) == playerColor) {
                	 count++;
                	 strike++;
                	 
                	 if(strike == 2)
                       	 count += SCORE_2_STRIKE;
                        else if(strike == 3)
                       	 count += SCORE_3_STRIKE;
                        else if(strike == 4)
                       	 count += SCORE_4_STRIKE;
                 }
                 else if(board.getState(row, iterCol) == enemyColor)
                 {
                	 enemyCount++;
                	 
                	 if(strike == 2)
                       	 count += SCORE_2_STRIKE;
                        else if(strike == 3)
                       	 count += SCORE_3_STRIKE;
                        else if(strike == 4)
                       	 count += SCORE_4_STRIKE;
                	 
                	 strike = 0;
                	 if(enemyCount >= 2) {
                		 count = -1;
                		 break;
                	 }
                 }
                 else
                 {
                	 strike = 0;
                 }
                 
                 if(strike == 2)
                	 count += SCORE_2_STRIKE;
                 else if(strike == 3)
                	 count += SCORE_3_STRIKE;
                 else if(strike == 4)
                	 count += SCORE_4_STRIKE;
             }
        }
        else
        {
        	for (int iterRow = 0; iterRow < board.getSize(); iterRow++) {
        		if (board.getState(iterRow, col) == playerColor) {
        			count++;
        			strike++;
                }
        		else if(board.getState(iterRow, col) == enemyColor)
                {
               	 	enemyCount++;
               	 	
               	 	if(strike == 2)
                   	 count += SCORE_2_STRIKE;
                    else if(strike == 3)
                   	 count += SCORE_3_STRIKE;
                    else if(strike == 4)
                   	 count += SCORE_4_STRIKE;
               	 	
               	 	strike = 0;
               	 	
					if(enemyCount >= 2) {
						count = -1;
						break;
					}
                }
        		else
        		{
        			if(strike == 2)
                      	 count += SCORE_2_STRIKE;
                       else if(strike == 3)
                      	 count += SCORE_3_STRIKE;
                       else if(strike == 4)
                      	 count += SCORE_4_STRIKE;
        			
        			strike = 0;
        		}
        		
        		if(strike == 2)
                 	 count += SCORE_2_STRIKE;
                  else if(strike == 3)
                 	 count += SCORE_3_STRIKE;
                  else if(strike == 4)
                 	 count += SCORE_4_STRIKE;
        	}
        }
        
        System.out.println("count: " + count + " row:" + row + " col: " + col + " horizontal: " + horizontal);

        return count;
    }
}
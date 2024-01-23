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
        long endTime = startTime + 5000;  // 5 seconds time limit
        List<Move> moves = board.getMovesFor(getColor());
        Move bestMove = null;
        int maxScore = Integer.MIN_VALUE;

        for (Move move : moves) {
            Board tempBoard = board.clone();
            tempBoard.doMove(move);

            int score = minMax(tempBoard, 4, Integer.MIN_VALUE, Integer.MAX_VALUE, false, endTime);
            if (score > maxScore) {
                maxScore = score;
                bestMove = move;
            }
        }

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

            int value = minMax(tempBoard, depth - 1, alpha, beta, !maximizingPlayer, endTime);

            if (maximizingPlayer) {
                bestValue = Math.max(bestValue, value);
                alpha = Math.max(alpha, bestValue);
            } else {
                bestValue = Math.min(bestValue, value);
                beta = Math.min(beta, bestValue);
            }

            if (beta <= alpha) {
                break;  // Beta cut-off
            }
        }

        return bestValue;
    }

    private int evaluate(Board board) {
        int score = 0;

        // Przykładowa heurystyka: Liczenie liczby dwóch kamieni gracza obok siebie w jednym rzędzie
        for (int row = 0; row < board.getSize(); row++) {
            for (int col = 0; col < board.getSize(); col++) {
                if (board.getState(row, col) == getColor()) {
                    // Sprawdzamy poziome i pionowe rządzenia
                    score += countAdjacentStones(board, row, col, 1, 0);  // Poziomo
                    score += countAdjacentStones(board, row, col, 0, 1);  // Pionowo

                    // Sprawdzamy przekątne
                    score += countAdjacentStones(board, row, col, 1, 1);  // \ Przekątna
                    score += countAdjacentStones(board, row, col, 1, -1); // / Przekątna
                }
            }
        }

        return score;
    }

    private int countAdjacentStones(Board board, int row, int col, int rowIncrement, int colIncrement) {
        int count = 0;
        Player.Color playerColor = getColor();

        // Sprawdzamy 2 kamienie obok siebie w danym kierunku
        for (int i = 0; i < 2; i++) {
            int newRow = row + i * rowIncrement;
            int newCol = col + i * colIncrement;
            
            List<Move> moves = board.getMovesFor(playerColor);

            if (board.getState(newRow, newCol) == playerColor) {
                count++;
            }
        }

        return count;
    }
}
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package put.ai.games.myplayer;

import java.util.List;
import java.util.Random;
import put.ai.games.game.Board;
import put.ai.games.game.Move;
import put.ai.games.game.Player;

public class MyPlayer extends Player {

    private Random random = new Random(0xdeadbeef);

    public static void main(String[] args) {}
    
    @Override
    public String getName() {
        return "Mikolaj Napierala 151812 Hubert Bogdanski 151751";
    }


    @Override
    public Move nextMove(Board b) {
        List<Move> moves = b.getMovesFor(getColor());
        return moves.get(random.nextInt(moves.size()));
    }
}

import funkin.Paths;
import funkin.graphics.FunkinSprite;
import funkin.play.PlayState;
import funkin.play.character.CharacterDataParser;
import funkin.play.character.CharacterType;
import funkin.play.song.Song;

class ChangeCharacter
{
	/*
	 * This will reset the characters back to
	 * what they were at the start of the song.
	 */
	override function onSongRetry(event):Void
	{
		super.onSongRetry(event);

		var stage:Stage = PlayState.instance.currentStage;
		var chart:Song = PlayState.instance.currentChart;

		var boyfriendId:String = chart.characters.player;
		var dadId:String = chart.characters.opponent;
		var girlfriendId:String = chart.characters.girlfriend;

		if (stage.getBoyfriend().characterId != boyfriendId)
		{
			changeCharacter(boyfriendId, CharacterType.BF);
		}

		if (stage.getDad().characterId != dadId)
		{
			changeCharacter(dadId, CharacterType.DAD);
		}

		if (stage.getGirlfriend().characterId != girlfriendId)
		{
			changeCharacter(girlfriendId, CharacterType.GF);
		}
	}

	/*
	 * This function should be used during the
	 * setup of the song to cache their assets.
	 *
	 * Otherwise the game stutters when the
	 * character switches, which is not ideal.
	 */
	function cacheCharacter(characterId:String):Void
	{
		var characterData = CharacterDataParser.fetchCharacterData(characterId);
		FunkinSprite.cacheTexture(Paths.image(characterData.assetPath));
	}

	/*
	 * This function does the actual character changing itself.
	 * Pretty simple as the game does all the heavy-lifting for us.
	 *
	 * P.S. Funkin' Crew if you're reading:
	 * pls make Stage.addCharacter() set characterType too thx <3
	 */
	function changeCharacter(characterId:String, characterType:CharacterType):Void
	{
		var stage:Stage = PlayState.instance.currentStage;

		switch (characterType)
		{
			case CharacterType.BF:
			{
				if (stage.getBoyfriend().characterId != characterId)
				{
					var boyfriend = stage.getBoyfriend(true);
					boyfriend = CharacterDataParser.fetchCharacter(characterId);
					boyfriend.characterType = CharacterType.BF;
					stage.addCharacter(boyfriend, CharacterType.BF);
				}
			}

			case CharacterType.GF:
			{
				if (stage.getGirlfriend().characterId != characterId)
				{
					var girlfriend = stage.getGirlfriend(true);
					girlfriend = CharacterDataParser.fetchCharacter(characterId);
					girlfriend.characterType = CharacterType.GF;
					stage.addCharacter(girlfriend, CharacterType.GF);
				}
			}

			case CharacterType.DAD:
			{
				if (stage.getDad().characterId != characterId)
				{
					var dad = stage.getDad(true);
					dad = CharacterDataParser.fetchCharacter(characterId);
					dad.characterType = CharacterType.DAD;
					stage.addCharacter(dad, CharacterType.DAD);
				}
			}
		}

		stage.refresh();
	}
}

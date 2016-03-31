INCLUDE "constants.asm"
INCLUDE "macros.asm"

;----------------------------------------------------------
;--- Bank 0: $Cxxx ----------------------------------------
;----------------------------------------------------------

SECTION "WRAM0", WRAM0

wTempCardCollection::
	ds $100
	ds $100

;--- Duel variables ----------------------------------------------

wPlayerDuelVariables:: ; c200

; In order to be identified during a duel, the 60 cards of each duelist are given an index between 0 and 59.
; These indexes are assigned following the internal order of the cards that make up the deck.
; This temporary index identifies the card during the current duel and within the duelist's deck.

; 60-byte array that indicates where each of the 60 cards is.
;	$00 - deck
;	$01 - hand
;	$02 - discard pile
;	$08 - prize
;	$10 - arena (active pokemon or a card attached to it)
;	$1X - bench (where X is bench position from 1 to 5)
wPlayerCardLocations:: ; c200
	ds DECK_SIZE
	ds $6

; Which cards are in player's hand, as numbers 0 to 59
wPlayerHand:: ; c242
	ds DECK_SIZE

; 60-byte array that maps each card to its position in the deck.
; This array is initialized to 00, 01, 02, ..., 59, until deck is shuffled.
wPlayerDeckCards:: ; c27e
	ds DECK_SIZE

; Stores x = (60 - deck remaining cards)
; The first x cards in the wPlayerDeckCards array are not actually in the deck
; For example, the top card of the player's deck is at wPlayerDeckCards + [wPlayerNumberOfCardsNotInDeck]
wPlayerNumberOfCardsNotInDeck:: ; c2ba
	ds $1

; Which card is in player's side of the field, as number 0 to 59
wPlayerArenaCard:: ; c2bb
	ds $1

; Which cards are in player's bench, as numbers 0 to 59
wPlayerBench:: ; c2bc
	ds BENCH_SIZE
	ds $7

wPlayerArenaCardHP:: ; c2c8
	ds $1
wPlayerBench1CardHP:: ; c2c9
	ds $1
wPlayerBench2CardHP:: ; c2ca
	ds $1
wPlayerBench3CardHP:: ; c2cb
	ds $1
wPlayerBench4CardHP:: ; c2cc
	ds $1
wPlayerBench5CardHP:: ; c2cd
	ds $1
	ds $19

wPlayerArenaCardSubstatus1:: ; c2e7
	ds $1

wPlayerArenaCardSubstatus2:: ; c2e8
	ds $1

wPlayerArenaCardSubstatus3:: ; c2e9
	ds $1

wPlayerArenaCardSubstatus4:: ; c2ea
	ds $1

wPlayerArenaCardSubstatus5:: ; c2eb
	ds $1

; Each bit represents a prize (1 = not taken ; 0 = taken)
wPlayerPrizes:: ; c2ec
	ds $1

wPlayerNumberOfCardsInDiscardPile:: ; c2ed
	ds $1

wPlayerNumberOfCardsInHand:: ; c2ee
	ds $1

; Pokemon cards in arena + bench
wPlayerNumberOfPokemonInPlay:: ; c2ef
	ds $1

wPlayerArenaCardStatus:: ; c2f0
	ds $1

; $00   - player
; $01   - link
; other - AI controlled
wPlayerDuelistType:: ; c2f1
	ds $1

; if under the effects of amnesia, which move (0 or 1) can't be used
wPlayerArenaCardDisabledMoveIndex:: ; c2f2
	ds $1
	ds $d

wOpponentDuelVariables:: ; c300

wOpponentCardLocations:: ; c300
	ds DECK_SIZE
	ds $6

wOpponentHand:: ; c342
	ds DECK_SIZE

wOpponentDeckCards:: ; c37e
	ds DECK_SIZE

wOpponentNumberOfCardsNotInDeck:: ; c3ba
	ds $1

wOpponentArenaCard:: ; c3bb
	ds $1

wOpponentBench:: ; c3bc
	ds BENCH_SIZE
	ds $7

wOpponentArenaCardHP:: ; c3c8
	ds $1
wOpponentBench1CardHP:: ; c3c9
	ds $1
wOpponentBench2CardHP:: ; c3ca
	ds $1
wOpponentBench3CardHP:: ; c3cb
	ds $1
wOpponentBench4CardHP:: ; c3cc
	ds $1
wOpponentBench5CardHP:: ; c3cd
	ds $1
	ds $19

wOpponentArenaCardSubstatus1:: ; c3e7
	ds $1

wOpponentArenaCardSubstatus2:: ; c3e8
	ds $1

wOpponentArenaCardSubstatus3:: ; c3e9
	ds $1

wOpponentArenaCardSubstatus4:: ; c3ea
	ds $1

wOpponentArenaCardSubstatus5:: ; c3eb
	ds $1

wOpponentPrizes:: ; c3ec
	ds $1

wOpponentNumberOfCardsInDiscardPile:: ; c3ed
	ds $1

wOpponentNumberOfCardsInHand:: ; c3ee
	ds $1

wOpponentNumberOfPokemonInPlay:: ; c3ef
	ds $1

wOpponentArenaCardStatus:: ; c3f0
	ds $1

; $00   - player
; $01   - link
; other - AI controlled
wOpponentDuelistType:: ; c3f1
	ds $1

wOpponentArenaCardDisabledMoveIndex:: ; c3f2
	ds $1
	ds $d

wPlayerDeck:: ; c400
	ds $80

wOpponentDeck:: ; c480
	ds $80
	ds $10

; this holds a list of cards (e.g. in hand or in bench) or the attack list of a pokemon card
wDuelCardOrAttackList:: ; c510
	ds $80

; this appears to be kept updated with some default text that is used
; when the text printing functions are called with text id $0000
wc590:: ; c590
	ds $70

;--- Text engine ------------------------------------------

wc600:: ; c600
	ds $100

wc700:: ; c700
	ds $100

wc800:: ; c800
	ds $100

wc900:: ; c900
	ds $100

;--- Engine -----------------------------------------------

wBufOAM:: ; ca00
	ds $a0

wcaa0:: ; caa0
	ds $10

wcab0:: ; cab0
	ds $1

wcab1:: ; cab1
	ds $1

wcab2:: ; cab2
	ds $1

; initial value of the A register--used to tell the console when reset
wInitialA:: ; cab3
	ds $1

; what console we are playing on, either 0 (DMG), 1 (SGB) or 2 (CGB)
; use constants CONSOLE_DMG, CONSOLE_SGB and CONSOLE_CGB for checks
wConsole:: ; cab4
	ds $1

wcab5:: ; cab5
	ds $1

wTileMapFill:: ; cab6
	ds $1

wIE:: ; cab7
	ds $1

wVBlankCtr:: ; cab8
	ds $1
	ds $1

; bit0: is in vblank interrupt?
; bit1: is in timer interrupt?
wReentrancyFlag:: ; caba
	ds $1

wLCDC:: ; cabb
	ds $1

wBGP:: ; cabc
	ds $1

wOBP0:: ; cabd
	ds $1

wOBP1:: ; cabe
	ds $1

wFlushPaletteFlags:: ; cabf
	ds $1

wVBlankOAMCopyToggle:: ; cac0
	ds $1
	ds $1

wcac2:: ; cac2
	ds $1

wCounterCtr:: ; cac3
	ds $1

wPlayTimeCounterEnable:: ; cac4
	ds $1

; byte0: 1/60ths of a second
; byte1: seconds
; byte2: minutes
; byte3: hours (lower byte)
; byte4: hours (upper byte)
wPlayTimeCounter:: ; cac5
	ds $5

wRNG1:: ; caca
	ds $1

wRNG2:: ; cacb
	ds $1

wCounter:: ; cacc
	ds $1

; the LCDC status interrupt is always disabled and this always reads as jp $0000
wLCDCFunctiontrampoline:: ; cacd
	ds $3

wVBlankFunctionTrampoline:: ; cad0
	ds $3

wDoFrameFunction:: ; cad3
	ds $1

wcad4:: ; cad4
	ds $1

wcad5:: ; cad5
	ds $1
	ds $8

wcade:: ; cade
	ds $4

wcae2:: ; cae2
	ds $e

wBufPalette:: ; caf0
	ds $80
	ds $4

;--- Serial transfer bytes (cb74-cbc4) --------------------

wSerialOp:: ; cb74
	ds $1

wSerialFlags:: ; cb75
	ds $1

wSerialCounter:: ; cb76
	ds $1

wSerialCounter2:: ; cb77
	ds $1

wSerialTimeoutCounter:: ; cb78
	ds $1
	ds $4

wSerialSendSave:: ; cb7d
	ds $1

wSerialSendBufToggle:: ; cb7e
	ds $1

wSerialSendBufIndex:: ; cb7f
	ds $1

wcb80:: ; cb80
	ds $1

wSerialSendBuf:: ; cb81
	ds $20

wSerialLastReadCA:: ; cba1
	ds $1

wSerialRecvCounter:: ; cba2
	ds $1

wcba3:: ; cba3
	ds $1

wSerialRecvIndex:: ; cba4
	ds $1

wSerialRecvBuf:: ; cba5 - cbc4
	ds $20
	ds $1

;--- Engine ----------------------------------------------

; In a duel, the main menu current or last selected menu item
; From 0 to 5: Hand, Attack, Check, Pkmn Power, Retreat, Done
wCurrentDuelMenuItem:: ; cbc6
	ds $1

; When we're viewing a card's information, the page we are currently at
; For Pokemon cards, values from $1 to $6 (two pages for move descriptions)
; For Energy cards, it's always $9
; For Trainer cards, $d or $e (two pages for trainer card descriptions)
wCardPageNumber:: ; cbc7
	ds $1
	ds $3

wBenchSelectedPokemon:: ; cbcb
	ds $1
	ds $2

wAttachedEnergiesAccum:: ; cbce
	ds $1

; When you're in a duel submenu like the cards in your hand and you press A,
; the following two addresses keep track of which item was selected by the cursor
wSelectedDuelSubMenuItem:: ; cbcf
	ds $1

wSelectedDuelSubMenuScrollOffset:: ; cbd0
	ds $1
	ds $35

wcc06:: ; cc06
	ds $1

; 0 = no one has won duel yet
; 1 = player whose turn it is has won the duel
; 2 = player whose turn it is has lost the duel
; 3 = duel ended in a draw
wDuelFinished:: ; cc07
	ds $1
	ds $1

wcc09:: ; cc09
	ds $1

wcc0a:: ; cc0a
	ds $4

; this seems to hold the current opponent's deck id - 2,
; perhaps to account for the two unused pointers at the
; beginning of DeckPointers
wOpponentDeckId:: ; cc0e
	ds $1
	ds $1

wcc10:: ; cc10
	ds $1

wcc11:: ; cc11
	ds $1

wcc12:: ; cc12
	ds $1

wIsPracticeDuel:: ; cc13
	ds $1
	ds $6

wDuelTheme:: ; cc1a
	ds $1

; holds the energies attached to a given pokemon card. 1 byte for each of the
; 8 energy types (including the unused one that shares byte with the colorless energy)
wAttachedEnergies:: ; cc1b
	ds NUM_TYPES

; holds the total amount of energies attached to a given pokemon card
wTotalAttachedEnergies:: ; cc23
	ds $1

; Used as temporary storage for a loaded card's data
wCardBuffer1:: ; cc24
	card_data_struct wCardBuffer1

wCardBuffer2:: ; cc65
	card_data_struct wCardBuffer2

wMoveBuffer:: ; cca6
	move_data_struct wMoveBuffer

; big-endian
wDamage:: ; ccb9
	ds $2

	ds $4

wccbf:: ; ccbf
	ds $2

wccc1:: ; ccc1
	ds $1

wTempCardId:: ; ccc2
	ds $1

wTempTurnDuelistCardId:: ; ccc3
	ds $1

wTempNonTurnDuelistCardId:: ; ccc4
	ds $1

	ds $1

; may contain 0 or 1 depending on which move was selected
wSelectedMoveIndex:: ; ccc6
	ds $1

; if affected by a no damage or effect substatus, this flag indicates what the cause was
wNoDamageOrEffect:: ; ccc7
	ds $2

wccc9:: ; ccc9
	ds $4

wcccd:: ; cccd
	ds $19

wcce6:: ; cce6
	ds $5

wcceb:: ; cceb
	ds $1

wccec:: ; ccec
	ds $1

wcced:: ; cced
	ds $2

wccef:: ; ccef
	ds $1

wccf0:: ; ccf0
	ds $1

wccf1:: ; ccf1
	ds $2

; color/pattern of the text box border. Values between 0-7?. Interpreted differently depending on console type
; Note that this doesn't appear to be a selectable option, just changes with the situation.
; For example the value 4 seems to be used a lot during duels.
wFrameType:: ; ccf3
	ds $1
	ds $10

wcd04:: ; cd04
	ds $1

wcd05:: ; cd05
	ds $1

wcd06:: ; cd06
	ds $1

wcd07:: ; cd07
	ds $1

wcd08:: ; cd08
	ds $1

wcd09:: ; cd09
	ds $1

wcd0a:: ; cd0a
	ds $1

wcd0b:: ; cd0b
	ds $2

wUppercaseFlag:: ; cd0d
	ds $1
	ds $1

; Handles timing of (horizontal or vertical) arrow blinking while waiting for user input.
wCursorBlinkCounter:: ; cd0f
	ds $1

wCurMenuItem:: ; cd10
	ds $1

wCursorXPosition:: ; cd11
	ds $1

wCursorYPosition:: ; cd12
	ds $1

wYDisplacementBetweenMenuItems:: ; cd13
	ds $1

wNumMenuItems:: ; cd14
	ds $1

wCursorTileNumber:: ; cd15
	ds $1

wTileBehindCursor:: ; cd16
	ds $1
	ds $81

wcd98:: ; cd98
	ds $1

wcd99:: ; cd99
	ds $1

wcd9a:: ; cd9a
	ds $88

; During a duel, this is always $b after the first attack.
; $b is the bank where the functions associated to card or effect commands are.
; Its only purpose seems to be store this value to be read by TryExecuteEffectCommandFunction.
wce22:: ; ce22
	ds $1d

wce3f:: ; cd3f
	ds $1

wce40:: ; ce40
	ds $3

wce43:: ; ce43
	ds $1

wce44:: ; ce44
	ds $3

; when printing text, number of frames to wait between each text tile
wTextSpeed:: ; ce47
	ds $1

wce48:: ; ce48
	ds $1

wce49:: ; ce49
	ds $1

wce4a:: ; ce4a
	ds $1

wce4b:: ; ce4b
	ds $3

wCoinTossScreenTextId:: ; ce4e
	ds $2

wce50:: ; ce50
	ds $1

wce51:: ; ce51
	ds $8

wce59:: ; ce59
	ds $7

wce60:: ; ce60
	ds $3

wce63:: ; ce63
	ds $9

wce6c:: ; ce6c
	ds $1

wce6d:: ; ce6d
	ds $1

wce6e:: ; ce6e
	ds $1

wce6f:: ; ce6f
	ds $d

wce7c:: ; ce7c

;----------------------------------------------------------
;--- Bank 1: $Dxxx ----------------------------------------
;----------------------------------------------------------

SECTION "WRAM1", WRAMX, BANK[1]
	ds $b5

wd0b5:: ; d0b5
	ds $c

wd0c1:: ; d0c1
	ds $1

wd0c2:: ; d0c2
	ds $1

wd0c3:: ; d0c3
	ds $3

wd0c6:: ; d0c6
	ds $1

wd0c7:: ; d0c7
	ds $1

wd0c8:: ; d0c8
	ds $1

wd0c9:: ; d0c9
	ds $1

wd0ca:: ; d0ca
	ds $1

wd0cb:: ; d0cb
	ds $43

wd10e:: ; d10e
	ds $3

wd111:: ; d111
	ds $1

wd112:: ; d112
	ds $1

;--- Music ------------------------------------------------

wMatchStartTheme:: ; d113
	ds $1
	ds $9

wPCPackSelection:: ; d11d
	ds $1

; 7th bit of each pack corresponds to whether or not it's been read
wPCPacks:: ; d11e
	ds $c
	ds $3

wPCLastDirectionPressed:: ; d12d
	ds $1
	ds $3

wd131:: ; d131
	ds $2

wBoosterViableCardList:: ; d133
	ds $1fb

wd32e:: ; d32e
	ds $1

wCurMap:: ; d32f
	ds $1

wPlayerXCoord:: ; d330
	ds $1

wPlayerYCoord:: ; d331
	ds $1
	ds $2

wd334:: ; d334
	ds $76

wd3aa:: ; d3aa
	ds $1

wd3ab:: ; d3ab
	ds $d

wd3b8:: ; d3b8
	ds $6a

wd422:: ; d422
	ds $8

wd42a:: ; d42a
	ds $82

wd4ac:: ; d4ac
	ds $12

wd4be:: ; d4be
	ds $6

wd4c4:: ; d4c4
	ds $1

wd4c5:: ; d4c5
	ds $1

wd4c6:: ; d4c6
	ds $4

wd4ca:: ; d4ca
	ds $5

wd4cf:: ; d4cf
	ds $108

wd5d7:: ; d5d7
	ds $44

wd61b:: ; d61b
	ds $3

wd61e:: ; d61e
	ds $4b

wBoosterDataIndex:: ; d669
	ds $1

wBoosterTempData:: ; d66a
	ds $1

wBoosterSelectedCardType:: ; d66b
	ds $1

wBoosterCurrRarity:: ; d66c
	ds $1

wBoosterDataAveragedChance:: ; d66d
	ds $1

wBoosterDataCommonAmount:: ; d66e
	ds $1

wBoosterDataUncommonAmount:: ; d66f
	ds $1

wBoosterDataRareAmount:: ; d670
	ds $1

wBoosterAmountOfCardTypeTable:: ; d671
	ds $09

wBoosterTempTypeChanceTable:: ; d67a
	ds $09

wBoosterCurrentCardType:: ; d683
	ds $1

wBoosterCurrentCardRarity:: ; d684
	ds $1

wBoosterCurrentCardSet:: ; d685
	ds $1

wBoosterDataRarityIndex:: ; d686
	ds $1

wBoosterDataEnergyFunctionPointer:: ; d687
	ds $2

wBoosterDataTypeChanceData:: ; d689
	ds $9
	ds $6f2

wMusicDC:: ; dd84
	ds $2

wMusicDuty:: ; dd86
	ds $4

wMusicWave:: ; dd8a
	ds $1

wMusicWaveChange:: ; dd8b
	ds $2

wMusicIsPlaying:: ; dd8d
	ds $4

wMusicTie:: ; dd91
	ds $c

wMusicMainLoop:: ; dd9d
	ds $12

wMusicOctave:: ; ddaf
	ds $10

wMusicE8:: ; ddbf
	ds $8

wMusicE9:: ; ddc7
	ds $4

wMusicEC:: ; ddcb
	ds $4

wMusicSpeed:: ; ddcf
	ds $4

wMusicVibratoType:: ; ddd3
	ds $4

wMusicVibratoType2:: ; ddd7
	ds $8

wMusicVibratoDelay:: ; dddf
	ds $8

wMusicVolume:: ; dde7
	ds $3

wMusicE4:: ; ddea
	ds $9

wMusicReturnAddress:: ; ddf3
	ds $8

INCLUDE "sram.asm"

package ;

import openfl.geom.Point;
import openfl.geom.Point;
import openfl.Vector;
import openfl.display.GradientType;
import openfl.display.Graphics;
import openfl.filters.DropShadowFilter;
import org.si.cml.CMLFiber;
import openfl.display.Shape;
import org.si.cml.CMLObject;
import openfl.geom.Matrix;
import openfl.events.Event;
import org.si.b3.CMLMovieClipTexture;
import org.si.cml.CMLSequence;
import openfl.display.BitmapData;
import openfl.geom.ColorTransform;

@:bitmap("Assets/characters.png") class CharacterData extends BitmapData {}
@:bitmap("Assets/ouya-spritesheet.png") class OuyaData extends BitmapData {}

class ResourceManager {
    public var bgangle:Float = -90;
    public var bgcolor1:Int = 0xf0f0ff;
    public var bgcolor2:Int = 0xb0b0cf;
    public var damageColt:ColorTransform = new ColorTransform(1, 1, 1, 1, -128, -128, -128, 0);
    public var playerTexture:CMLMovieClipTexture;
    public var shotTexture:CMLMovieClipTexture;
    public var fonttex:CMLMovieClipTexture;
    public var lfonttex:CMLMovieClipTexture;
    public var numtex:CMLMovieClipTexture;
    public var lnumtex:CMLMovieClipTexture;
    public var scoreTextures:Array<CMLMovieClipTexture>;
    public var explosionTextures:Array<CMLMovieClipTexture>;
    public var enemyTextures:Array<CMLMovieClipTexture>;
    public var bulletTextures:Array<CMLMovieClipTexture>;
    public var ouyaTexture:CMLMovieClipTexture;
    public var enemyColors:Array<Int>;
    public var lifeUpTexture:CMLMovieClipTexture;
    public var background:BitmapData = new BitmapData(450, 450, false, 0xffffff);
    public var sequences:Dynamic;
    public var characterMap:BitmapData;
    public var stageSequence:CMLSequence;
    public var groupID:Array<Int> = [0, 0, 0, 3, 3, 3, 6, 7, 7, 9, 10, 9, 0, 13, 0];
    public var shotSeq:Array<CMLSequence>;
    public var groupSeq:Array<CMLSequence>;
    public var enemySeq:Array<CMLSequence>;
    public var onResourceLoaded:Void->Void;
    public var rankingMaker:Dynamic;
    public var loaderInfoParameters:Dynamic;


    //var cmlScript:String = "w60[[w60 -$l * 5 & rungroup0l$r += 0.5]10w70];
    //var cmlScript:String = "&rungroup0;
    var cmlScript:String = "w60[[w60 -$l * 5 & rungroup0l$r += 0.5]10w70];
    #S1{@{^ f - 12[q - 14f{vx - 6a0.3, - 1}q14f{vx8a - 0.4, - 1}w2q - 14f{vx - 2a0.1, - 1}q14f{vx4a - 0.2, - 1}w2q - 14f{vx - 8a0.4, - 1}q14f{vx6a - 0.3, - 1}w2q - 14f{vx - 4a0.2, - 1}q14f{vx2a - 0.1, - 1}w2]}
^ f12{ay - 1}[ha0q - 12fq0fq12fw2q - 14fq0fq14fw2ha0q - 12fq0fq12fw2q - 10fq0fq10fw2]};
#S2{ha0[[bm4, 30 + $l * 10f30w2]3[bm4, 60 - $l *10f30w2]3]};
#S3{ha0[[qx$l * 10 - 30f30]7w2]};
#G0{qy - 225[?$?<0.4qx- $? * 150 - 25n{}qx$? * 150 + 25n{}:qx$?? * 175n{}] & groupbonus0};
#G3{l$1 = $i?(3)[?$1==2{qx - 225[qy - 160n{}w5]5}{qx225[qy - 160n{}w5]5}:qx$1 * 450 - 225[qy - 160n{}w5]10] & groupbonus200};
#G6{l$1 = $i?(3)[?$1==2{qx - 225[qy - $l * 20n{}w5]5}{qx225[qy - $l * 20n{}w5]5}:qx$1 * 450 - 225[qy - $l* 15n{}w5]10] & groupbonus200};
#G7{l$1 = $i?(3)[?$1==2{qx - 225[qy - 120 + $l *20n{}w5]5}{qx225[qy - 120 + $l * 20n{}w5]5}:qx$1 * 450 - 225[qy - 120+ $l * 15n{}w5]10] & groupbonus200};
#G9{qy - 225[s?$i?(5)[qx$?? * 200n{}w3]10:1[qx$l * 40 -180n{}w3]10:2[qx180 - $l *40n{}w3]10:3[qx180 - $l *40n{}qx$l * 40 - 180n{}w3]5:4[qx20 + $l *40n{}qx - $l * 40 - 20n{}w3]5] & groupbonus200};
#G10{qy - 225[s?$i?(3)[qx$l * 40 - 180n{}w3]10:1[qx180 - $l *40n{}w3]10:2[qx180 - $l *40n{}qx$l * 40 - 180n{}]10] & groupbonus200};
#G13{q175, - 225[?$?<0.4n{}w15n{}:n{}] & groupbonus0};
#E0{20, 100#T{[bm$2, $1, , 2bm2, 2f$3{3}w$2 * 2bm$2, - $1, , 2bm2, 2f$3{3}w]3}i20py - 120~ha180[s?$r &T 160, 8, 6:35 & T 160, 8, 7:70 & T 160, 9, 8:105 & T 160,10, 8:140 & T 140, 10, 10:180 & T 140, 10,12]ay0.1};
#E1{16, 100#B{bm$1, 360bm$2, 15, 5, 1}i20py - 120~ha$? * 360[s?$r & B 12, 12:40 &B 12, 14:70 & B 14,14:110 & B 16, 14:140& B 18, 14:190 & B 20, 14]f7{1}w60ay0.1};
#E2{20, 100i20py - 120~bs37, 10, , 1bm2, , 0.2 ^ f{2}ha90[s?$rf4:30[hs180f4.5]2f:60[hs120f5]3:90[hs90f5]4:130[hs88f5.5]4]w90ay0.1};
#E3{9, 5{l$1 = $sx * - 12l$2 = $sx *6[v$1, 0w6v$2, 10w9v$1,0w6v$2, - 10w9]} br1, 40[s?$rw70 - $r *0.4f3{0}:110w25f3{0}:250w22br1, 40bm2, 3f4{0}]};
#E4{9, 5 ^ f{4}{[s?$r[w45 - $r * 0.3f6 + $r * 0.08]:70[w15f12]:100[w15f13.5]:130[w15f15]:190[w12ht$?? * 10f16]]}{[csa10w]}l$1 = $sx * 270l$2 = $sx * -90[i0ha$1rcw10i45ha$2rc~]};
#E5{9, 5vx$sx * - 5ha180[s?$rbr1, 30, 2 ^ f4{2}:30br1, 40, 2 ^ f4{2}:55br1, 30, 2 ^ f4{2}:80br2, 30, 2 ^ f4{2}:105br2, 30, 3 ^ f6{2}:140br2, 60, 4bm2, 20^ f7{2}:220br2, 30, 3bm2, ,0.8 ^ f10{5}][vy - 8ay0.8w22f4]};
#E6{7, 3{[s?$rw30bm2, 80 - $r * 0.4f6{0}:100w30bm4, 160 - $r * 0.4f6{0}:200:w8bm4, 90f6{0}w22f12{3}]}v$sx * - 24, 0i45v$sx * 8,4~ay - 0.5};
#E7{7, 3{w$? * 40 + 10ha[s?$r[f4{1ay0.2 + $r * 0.003}w80 - $r * 0.4]:120ha$?? * 30[f4{1ay0.5}w25]:220bm2, 30, 2ha$?? * 20[f4{1ay0.6}w20]]}v, - 4i60px$sx * - 200v$sx *6, 4~htad - 0.3};
#E8{7, 3{w20[s?$rbr$r * 0.02 + 1,120, 2, 2f4 + $r * 0.03{2}:210br4, 120, 2, 2bm2, , 2f14{5}]}v$sx * - 12, - 8i60p$sx * 120, 0v$sx * - 12, 4~ay- 0.5};
#E9{3, 1 ^ f{0}{ht$?? * 5ad1.2w14ad - 1.2}[s?$rbm2, , 1{w25 - $r * 0.3f6 + $r * 0.12}w25[w18 - $r * 0.1f6 + $r* 0.12 + $l]:80w10bm3, ,2f14{3}w15[w10f16 + $l]:140w10bm4,, 3f16{3}w15[w10f18 + $l * 2]]};
#E10{3, 1 ^ f{1}vy48i12vy0~ha$? * 360[s?$rbm2+ $r * 0.03, 360:230bm10,360]f$? * 1.5 + 3w5ay -0.12[w20ha$? * 360f]};
#E11{3, 1[s?$rvy24:85vy32:175vy40]i8vy0~[s?$rbm3, , 1:30bm3, , 1.5:60bm2, 360bm3, , 1.5:125bm3, 240bm3, , 1.5:260bm3, 40bm3, , 1.5]f - 8{5hoad0.6}w5ad1};
#E12{35, 300i20py - 120~[s?$rl$1 = 75l$2 = 6:25l$1 =60l$2 = 7:50l$1 = 45l$2= 8:70l$1 = 30l$2 = 9:90l$1 = 25l$2 = 10:150l$1 = 15l$2 = 10][i0vx$i?(2) * 8 - 4i12vx~bm12, 360f40{wbm2, $1f$2{0}ko}$1, $2w12]5ay1};
#E13{35, 300i20py - 120~{w25[s?$rbm4, 270:40bm5, 360:80bm5, 288:120bm7, 309][ht - 24bv0.5f4{4}hs4[f]5bv - 0.5[f]7w50]6}i50[px - 175v~px175v~]3ay1};
#E14{35, 300i20py - 120~vy - 0.25[ht - 90f8{5hoad - 0.5ht - 30 * $1f6{2}hs$r * 0.04 * $1[w4f]7ko}1w30ht90f8{.}- 1w]3ay1};
#E15{[v1,0 w120 v-1,0 w120]}";

    static private inline var RANKING_WINDOW_URL:String = "http://swf.wonderfl.net/swf/usercode/7/7a/7af0/7af0cf8f5b74242e7eb21337bfd241a9682d2407.swf";
    //const SOUND_FONT_URL:String = "sound.png";
    static private inline var SOUND_FONT_URL:String = "http://assets.wonderfl.net/images/related_images/a/aa/aa9a/aa9a00df008e71a100500b5c90da9b71734af5e8";

#if SION_ENABLED
    //SiON: public var sionDriver:SiONDriver = new SiONDriver();
    //SiON: public var bgm:SiONData;
    //SiON: public var gameover:SiONData;
    //SiON: public var beep:SiONVoice;
#end

    public function new(onResourceLoaded:Void->Void, loaderInfoParameters:Dynamic) {
        this.loaderInfoParameters = loaderInfoParameters;
        this.onResourceLoaded = onResourceLoaded;
        // Loader --------------------------------------------------
#if SION_ENABLED
        var loader:SoundLoader = new SoundLoader();
        loader.setURL(new URLRequest(CHARA_MAP_URL), "cmap", "img", checkPolicyFile);
        loader.setURL(new URLRequest(SOUND_FONT_URL), "sample", "ssfpng", checkPolicyFile);
        loader.setURL(new URLRequest(RANKING_WINDOW_URL), "ranking", "swf");
        //loader.setURL(new URLRequest("nomltest.mml"), "bgm", "txt");
        //loader.setURL(new URLRequest("gameover.mml"), "gameover", "txt");
        //loader.setURL(new URLRequest("script.cml"), "script", "txt");
        loader.addEventListener(Event.COMPLETE, _onComplete);
        loader.loadAll();
#else
        _onComplete(new Event(Event.COMPLETE));
#end
    }

    private function _onComplete(e:Event):Void {
#if SION_ENABLED
        var data:Dynamic = SoundLoader(e.target).hash;
#end
        var bmp:BitmapData = new BitmapData(128, 128, true, 0xffffffff);
        var red:Array<Float> = [0.7, 0.4, 0.4];
        var grn:Array<Float> = [0.4, 0.7, 0.4];
        var blu:Array<Float> = [0.4, 0.4, 0.7];
        var i:Int;
        var j:Int;
        var c:Int;
        var mat:Matrix = new Matrix();
        var t:CMLMovieClipTexture;
        var bd:BitmapData;
        var lbl:String;

        // CannonML --------------------------------------------------
        CMLObject.setGlobalRankRange(0, 999);
        CMLSequence.registerUserCommand("rungroup", _onRunGroup, 1);
        CMLSequence.registerUserCommand("groupbonus", _onGroupBonus, 1);

        // Textures --------------------------------------------------
        var ouya:BitmapData = new OuyaData(0,0);
        ouyaTexture = newTexture(ouya, 0, 0, 32, 32, 6, 1, [1.0,1.0,1.0], false, false);

        characterMap = new CharacterData(0,0);
        bmp.copyChannel(characterMap, bmp.rect, bmp.rect.topLeft, 1, 8);
        playerTexture = newTexture(bmp, 16, 0, 16, 16, 1, 2, blu, true, true);
        shotTexture = newTexture(bmp, 56, 0, 8, 16, 1, 2, [0.7, 0.6, 0.4], false, false);
        fonttex = newTexture(bmp, 0, 64, 8, 8, 96, 2, [0.375, 0.375, 0.5], true, false);
        lfonttex = newTexture(bmp, 0, 64, 8, 8, 96, 4, [0.375, 0.375, 0.5], true, false);
        numtex = newTexture(bmp, 0, 112, 6, 6, 42, 2, [0.375, 0.375, 0.375], false, false);
        lnumtex = newTexture(bmp, 0, 112, 6, 6, 42, 4, [0.75, 0.25, 0.25], false, false);
        // text
        scoreTextures = [];
        for (i in 0...51) scoreTextures.push(renderText('${i}0', numtex));
        for (i in 1...4) scoreTextures[i * 100] = renderText('${i}000', lnumtex);
        lifeUpTexture = renderText("1UP", lnumtex);
        enemyTextures = [];
        enemyColors = [];
        // enemies
        for (i in 0...4) {
            enemyTextures.push(newTexture(bmp, i * 16 + 64, 0, 16, 16, 1, 2, blu, true, true));
            enemyTextures.push(newTexture(bmp, i * 16 + 64, 0, 16, 16, 1, 2, grn, true, true));
            enemyTextures.push(newTexture(bmp, i * 16 + 64, 0, 16, 16, 1, 2, red, true, true));
            enemyColors.push(0x9999c3);
            enemyColors.push(0x99c399);
            enemyColors.push(0xc39999);
        }
        enemyTextures.push(newTexture(bmp, 64, 0, 16, 16, 1, 4, blu, true, true));
        enemyTextures.push(newTexture(bmp, 80, 0, 16, 16, 1, 4, grn, true, true));
        enemyTextures.push(newTexture(bmp, 96, 0, 16, 16, 1, 4, red, true, true));
        enemyTextures.push(newTexture(bmp, 112, 0, 16, 16, 1, 4, [0.7, 0.7, 0.4], true, true));
        enemyColors.push(0x9999c3);
        enemyColors.push(0x99c399);
        enemyColors.push(0xc39999);
        enemyColors.push(0xc3c399);
        // explosions
        explosionTextures = [];
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 4, blu, true, false));
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 4, grn, true, false));
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 4, red, true, false));
        for (i in 1...4) {
            explosionTextures.push(explosionTextures[0]);
            explosionTextures.push(explosionTextures[1]);
            explosionTextures.push(explosionTextures[2]);
        }
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 6, blu, true, false));
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 6, grn, true, false));
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 6, red, true, false));
        explosionTextures.push(newTexture(bmp, 0, 32, 16, 16, 16, 6, [0.7, 0.7, 0.4], true, false));
        // bullets
        bulletTextures = [
        newTexture(bmp, 0, 16, 8, 8, 6, 2, blu, true, false),
        newTexture(bmp, 0, 24, 8, 8, 8, 2, grn, true, false),
        newTexture(bmp, 64, 16, 8, 8, 8, 2, red, true, false),
        newTexture(bmp, 64, 24, 8, 8, 8, 2, blu, true, false),
        newTexture(bmp, 64, 24, 8, 8, 8, 2, grn, true, false),
        newTexture(bmp, 64, 24, 8, 8, 8, 2, red, true, false),
        newTexture(bmp, 48, 16, 8, 8, 2, 2, red, true, false)
        ];

        // Background --------------------------------------------------
        var drawer:Shape = new Shape();
        var g:Graphics = drawer.graphics;
        mat.createGradientBox(450, 450, (bgangle + 90) * 0.017453292519943295, 0, 0);
        g.clear();
        g.beginGradientFill(GradientType.LINEAR, [bgcolor1, bgcolor2], [1, 1], [0, 255], mat);
        g.drawRect(0, 0, 720, 480);
        g.endFill();
        background.draw(drawer);
        g.lineStyle(2, 0, 0.125);
        i = 0;
        while (i <= 450) {
            g.moveTo(0, i);
            g.lineTo(450, i);
            g.moveTo(i, 0);
            g.lineTo(i, 450);
            i += 50;
        }
        background.draw(drawer);

#if SION_ENABLED
            // Sound --------------------------------------------------
        beep = new SiONVoice(0, 0, 63, 36, 4, 0, 0, - 4);
        sionDriver.noteOnExceptionMode = SiONDriver.NEM_IGNORE;
        sionDriver.setSamplerTable(0, data["sample"].samplerTables[0]);
            //bgm = sionDriver.compile(data["bgm"]);
        bgm = sionDriver.compile(mmlMain);
            //gameover = sionDriver.compile(data["gameover"]);
        gameover = sionDriver.compile(mmlGameOver);
#end
            // Sequences --------------------------------------------------
            //stageSequence = new CMLSequence(data["script"]);
        stageSequence = new CMLSequence(cmlScript);
        sequences = stageSequence.childSequence;
        var childSequence = sequences.get("S1");
        shotSeq = [];
        shotSeq.push(childSequence);
        childSequence = sequences.get("S2");
        shotSeq.push(childSequence);
        childSequence = sequences.get("S3");
        shotSeq.push(childSequence);
        groupSeq = [];
        enemySeq = [];
        for (i in 0...32) {
            childSequence = sequences.get('G$i');
            if (childSequence != null) {
                groupSeq[i] = childSequence;
            }

            childSequence = sequences.get('E$i');
            if (childSequence != null) {
                enemySeq[i] = childSequence;
            }
        }

            // Ranking window
        //var param:Dynamic = {
        //    tweet:"Nomltest FL [SCORE:%SCORE%/LEVEL:%SCORE2%] #wonderfl",
        //    scoreTitle:"SCORE",
        //    title:"Nomltest FL Net Ranking"
        //}
        //rankingMaker = data["ranking"];
        //rankingMaker.initialize(new WonderflAPI(loaderInfoParameters), param);
        //rankingMaker.score2(12, "Lv.%SCORE%", "LEVEL");
        //rankingMaker.score3(15, "%SCORE% eat", "EATEN");

        onResourceLoaded();
    }

    private var shadowFilter:DropShadowFilter = new DropShadowFilter(3, 45, 0, 0.5, 4, 4);

    // 'shd' is shadow
    /** newTexture
     *  @param bmp source texture
     *  @param x X coordinate of left edge on source texture
     *  @param y Y coordinate of top edge on source texture
     *  @param w texture width
     *  @param h texture height
     *  @param a animation count
     *  @param scale scale factor (same scale is used for both width and height)
     *  @param c Array of 3 Floats for color transformation
     *  @param shadow Add shadow
     *  @param flash Flash the texture
     */
    private function newTexture(bmp:BitmapData, x:Float, y:Float, w:Float, h:Float, a:Int, scale:Float,
                                c:Array<Float>, shadow:Bool, flash:Bool):CMLMovieClipTexture
    {
        var orig:CMLMovieClipTexture = new CMLMovieClipTexture(bmp, cast(x,Int), cast(y,Int), cast(w,Int), cast(h,Int),
                                                              false, a);
        var tex:CMLMovieClipTexture;

        tex = orig.cutout(scale, scale, 0, new ColorTransform(c[0], c[1], c[2], 1), 0, (shadow) ? 6 : 0);
        if (flash) {
            tex.animationPattern = new Vector<CMLMovieClipTexture>(2, true);
            tex.animationPattern[0] = tex;
            tex.animationPattern[1] = orig.cutout(scale, scale, 0, new ColorTransform(1 - (1 - c[0]) * 0.6, 1 - (1 - c[1]) * 0.6, 1 - (1 - c[2]) * 0.6, 1), 0, (shadow) ? 6 : 0);
        }
        if (shadow) {
            var i:Int, imax:Int = tex.animationCount, bmd:BitmapData;
            for (i in 0...imax) {
                bmd = tex.animationPattern[i].bitmapData;
                bmd.applyFilter(bmd, bmd.rect, bmd.rect.topLeft, shadowFilter);
            }
        }
        return tex;
    }

    public function renderText(txt:String, font:CMLMovieClipTexture, asciiOffset:Int = 48):CMLMovieClipTexture {
        var pt:Point = new Point();
        var i:Int;
        var imax:Int = txt.length;
        var t:CMLMovieClipTexture;
        var bd:BitmapData = new BitmapData(font.width * imax, font.height, true, 0);

        for (i in 0...imax) {
            t = font.animationPattern[txt.charCodeAt(i) - asciiOffset];
            bd.copyPixels(t.bitmapData, t.rect, pt);
            pt.x += font.width;
        }
        return new CMLMovieClipTexture(bd);
    }

    public function print(x:Float, y:Float, txt:String, font:CMLMovieClipTexture, pitch:Int, asciiOffset:Int = 32):Void
    {
        //trace('Printing "$txt" @ ($x,$y). pitch=$pitch, offset=$asciiOffset');
        var tx:Float = x + 8, ty:Float = y + 8, i:Int, imax:Int = txt.length;
        for (i in 0...imax) {
            Main.mc.copyTexture(font, Math.round(tx), Math.round(ty), txt.charCodeAt(i) - asciiOffset);
            tx += pitch;
        }
    }

    public function showRanking(onClose:Void->Void):Void {
        // Don't think this is implemented in haxe at the moment, so it's commented out until I can test.
        //var window = rankingMaker.makeRankingWindow();
        //window.addEventListener(Event.CLOSE, onClose);
        //Noml.mc.parent.addChild(window);
    }

    public function registerRanking(onClose:Void->Void):Void {
        // Don't think this is implemented in haxe at the moment, so it's commented out until I can test.
        //var window = rankingMaker.makeScoreWindow(scrManager.score, scrManager.level, scrManager.eaten);
        //window.addEventListener(Event.CLOSE, onClose);
        //Noml.mc.parent.addChild(window);
    }

    // called from &rungroup command in CML

    private function _onRunGroup(fbr:CMLFiber, args:Array<Dynamic>):Void {
        var enemyType:Int = (args[0] == 0) ? Math.round(Math.random() * 14) : (cast(args[0], Int) - 1);
        Group.run(groupID[enemyType], enemyType);
    }

    // called from &groupbonus command in CML

    private function _onGroupBonus(fbr:CMLFiber, args:Array<Dynamic>):Void {
        var g:Group = cast(fbr.object, Group);
        if (g != null) {
            g.finished = true;
            g.bonus = args[0];
        }
    }
}

